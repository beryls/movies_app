class MoviesController < ApplicationController
  def search
    @searched = Imdb::Search.new(params[:title]).movies.slice(0, 10)
    binding.pry
    render 'index'
  end

  def index
    @movies = Movie.all
  end
end