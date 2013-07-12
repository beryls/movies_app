class Movie < ActiveRecord::Base
  attr_accessible :title, :year, :plot, :mpaa_rating, :rating
end