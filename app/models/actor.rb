class Actor < ActiveRecord::Base
  belongs_to :movie
  validates :name, uniqueness: true

  require 'nokogiri'
  require 'open-uri'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  def self.get_list_of_movie_actors
    actors_list = Api::MoviesApiController.get_movie_actors
    actors_list['movies'].each do |movie|
      movie['abridged_cast'].each do |actor|
        found_actor_from_api = Actor.where(actor_id: [actor['id']])
        if found_actor_from_api
          url = "https://en.wikipedia.org/wiki/#{actor['name'].gsub(' ', '_')}"
          doc = Nokogiri::HTML(open(url))
          text = doc.at_css('p').text
          Actor.create(name: actor['name'], actor_id: actor['id'], wiki: text)
          Actor.update_all(name: actor['name'], actor_id: actor['id'], wiki: text)
        else
          find_and_delete_old_actors = Actor.find(params[:id])
          Actor.destroy_all(find_and_delete_old_actors)
        end
      end
    end
  end
end
