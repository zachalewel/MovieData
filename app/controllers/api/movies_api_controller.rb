require 'unirest'

module Api
  class MoviesApiController < ApplicationController

    def self.get_top_theater_movies
      @parse_movie_api_object = Unirest.get "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=qtqep7qydngcc7grk4r4hyd9",
        headers: {"Accept" => "application/json"}
      @parse_movie_api_object.body
    end

    def self.get_movie_actors
      @parse_actor_api_object = Unirest.get "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=qtqep7qydngcc7grk4r4hyd9",
        headers: {"Accept" => "application/json"}
      @parse_actor_api_object.body
    end
  end
end
