require 'json'
require 'open-uri'
require 'nokogiri'


Ingredient.destroy_all

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
list_serialized = open(url).read
list = JSON.parse(list_serialized)
list['drinks'].each do |hash|
 value = hash['strIngredient1']
 ingredient = Ingredient.create(name: value)
 p ingredient
end

puts "#{Ingredient.count} ingredient created"


html_content = 'https://www.cocktailicious.nl/index-cocktails/'
cocktail_titles = ""
image_array = []
html_file = open(html_content).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search('.elementor-post__title').each do |element|
  Cocktail.create(name: element.text.strip)
end
html_doc.search('.attachment-medium').each do |element|
 image_array << element.attr('src')
end
new_array = image_array.each_with_index.map{|url, index| url if index % 2 == 0}

