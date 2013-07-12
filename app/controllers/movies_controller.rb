class MoviesController < ApplicationController
  def search
    @searched = Imdb::Search.new(params[:title]).movies[0..14]
    render 'index'
  end

  def index
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
    movie = Movie.new(title: query.title, year: query.year,
      plot: query.plot, mpaa_rating: query.mpaa_rating, rating: params[:rating])
    movie.title = query.title
    movie.year = query.year
    movie.plot = query.plot
    movie.mpaa_rating = query.mpaa_rating
    movie.rating = params[:rating]
    movie.save
    redirect_to '/movies'
  end

  def change_rating
    movie = Movie.find(params[:id])
    case params[:pref]
    when 'up'
      if movie.rating <100
        movie.rating += 1
      end
    when 'down'
      if movie.rating > 0
        movie.rating -= 1
      end
    when 'fave'
      movie.rating = 100
    end
    movie.save
    redirect_to movie
  end
end