class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :recent_recipies
  before_action :authenticate_user!, only: [:update, :destroy, :edit, :new, :search]
  include RecipesHelper
  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.paginate(:page => params[:page], :per_page => 20)
    @featured = Recipe.order("RANDOM()").limit(1)[0]

    @user = User.new
    #@recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    @latest = Recipe.last(4)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    render "/recipes/search"
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    # uploadFile(@recipe.image)
    # @recipe.image = @recipe.image.original_filename
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    puts 'search def started...'
    @video = VideoInfo.new(params[:video_link])
    unless @video.nil?
      puts 'inside unless'
      @recipe = Recipe.new
      @recipe.title = @video.title
      @recipe.image = @video.thumbnail_medium
      @recipe.large_image = @video.thumbnail_large
      @recipe.video_link = params[:video_link]
    end

   respond_to do |format|
      # if !@recipe.nil?
        format.js  { render :partial => "recipes/details", :locals => {:recipe => @recipe, :query => params[:video_link]} }
        format.html    { render "recipes/search" }
      # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :creator, :url, :ingredients, :serving, :notes, :image, :tags, :published, :video_link, :large_image)
    end

    def recent_recipies
      @recent = Recipe.order('created_at DESC').limit(10)
    #@recipes = Recipe.all
    end

    def uploadFile(image)
      post = Recipe.save(image)
  end

end
