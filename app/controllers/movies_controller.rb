class MoviesController < ApplicationController
  def search
    @searched = Imdb::Search.new(params[:title]).movies[0..14]
    render 'index'
  end

  def index
    @movies = Movie.all
  end

  def show
    @movie = Imdb::Movie.new(params[:id])
  end
end