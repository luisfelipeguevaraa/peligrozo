class MoviesController < ApplicationController

  def index
  end

  def show
    @movie = Movie.includes(:theaters).find params[:id]
    @response = {movie: @movie, theaters: @movie.theaters}
    respond_to do |format|
      format.json  { render :json => @response }
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:id)
  end
end