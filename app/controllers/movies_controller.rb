class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    if params[:movie][:photo].present?
      render :action => "crop"
    else
      redirect_to @movie
    end
  end

  def update_cropping_image
    if params[:commit] != "Don't Crop"
      custom_theme =  Movie.find_by(id: params["movie"]["theme_id"])
      img = MiniMagick::Image.open(custom_theme.cover_image_physical)
      crop_string = params["movie"]["crop_w"]+"x"+params["movie"]["crop_h"]+"+"+params["movie"]["crop_x"]+"+"+params["movie"]["crop_y"]
      img.crop(crop_string)
      img.write custom_theme.cover_image_physical
    end 
    redirect_to movies_path
  end

  def update    
    @movie.update(movie_params)
    if params[:movie][:photo].present?
      render :action => "crop"
    else
      redirect_to @movie
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @movie = Movie.find(params[:id])
    @movie.upvote_from current_member
    redirect_to movies_path
  end

  def downvote
    @movie = Movie.find(params[:id])
    @movie.downvote_from current_member
    redirect_to movies_path
  end

  private    
    def set_movie
      @movie = Movie.find(params[:id])
    end
    
    def movie_params
      params.require(:movie).permit(:name, :photo)
    end
end
