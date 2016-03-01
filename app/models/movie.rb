class Movie < ActiveRecord::Base
  has_many :actors

  def self.get_theater_movies
    top_movies = Api::MoviesApiController.get_top_theater_movies
    top_movies['movies'].each do |movie|
        found_movie = Movie.where(movie_id: movie['id']).first
        if found_movie
          Movie.update_attributes(name: movie['title'], production_year: movie['year'], description: movie['synopsis'])
        elsif
          Movie.create(:name => movie['title'], :production_year => movie['year'], :description => movie['synopsis'])
        else
         find_delete_old_movies = Movie.find(params[:id])
          Movie.destroy_all(find_delete_old_movies)
        end
      end
    end
  end
