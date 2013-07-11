class MoviesController < ApplicationController
  def search
    @searched = Imdb::Search.new(params[:title]).movies[0..14]
    render 'index'
  end

  def index
    @movies = Movie.all
    @faves = Movie.where(rating: 100)
    @saves = Movie.where('rating < ?', 100)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def details
    @movie = Imdb::Movie.new(params[:id])
  end

  def save
    query = Imdb::Movie.new(params[:id])
    movie = Movie.new()
    movie.title = query.title
    movie.year = query.year
    movie.plot = query.plot
    movie.mpaa_rating = query.mpaa_rating
    movie.rating = 50
    movie.save
    redirect_to '/movies'
  end

  def fave
    query = Imdb::Movie.new(params[:id])
    movie = Movie.new()
    movie.title = query.title
    movie.year = query.year
    movie.plot = query.plot
    movie.mpaa_rating = query.mpaa_rating
    movie.rating = 100
    movie.save
    redirect_to '/movies'
  end
end