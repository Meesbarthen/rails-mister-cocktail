class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
    @scrapper = scrapper
  end

  def show
    @cocktail = cocktail_find
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = cocktail_find
  end

  def update
    @cocktail = cocktail_find
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path
    else
      render :new
    end
  end

  def destroy
    @cocktail = cocktail_find
    @cocktail.destroy

    redirect_to cocktails_path
  end

  def scrapper
    # require 'nokogiri'
    # require 'open-uri'

    # scrapped_recipes = []
    # html_content = 'https://uk.thebar.com/recipe/mojito'
    # doc = Nokogiri::HTML(File.open(html_content), nil, 'utf-8')
    # doc.search('.item-hero-img').take(1).each do |element|
    #   img = element.search('img')
    #   description = element.search('.fixed-recipe-card__description').text.strip
    #   rating = element.search('.data-ratingstars').text.strip
    #   scrapped_recipes << Recipe.new(title, description, rating)

  end

  private

  def cocktail_find
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
