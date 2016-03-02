require 'nokogiri'
require 'open-uri'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module Scrape
  class ActorsTextScrapeController < ApplicationController
    def self.get_actors_text
      actors_list = Api::MoviesApiController.get_movie_actors
      actors_list['movies'].each do |movie|
        movie['abridged_cast'].each do |actor|
          @found_actor_from_api = Actor.where(actor_id: actor['id'])
          generic_string = 'No Information for this actor'

          if @found_actor_from_api
            url = "https://en.wikipedia.org/wiki/#{actor['name'].gsub(' ', '_')}"
            begin

              doc = Nokogiri::HTML(open(url))
              text = doc.at_css('p').text
              @found_actor_from_api.update_all(name: actor['name'], actor_id: actor['id'], wiki: text)
              @found_actor_from_api.create(name: actor['name'], actor_id: actor['id'], wiki: text)

            rescue OpenURI::HTTPError => error
              if error.message == '404 Not Found'
                @found_actor_from_api.update_all(name: actor['name'], actor_id: actor['id'], wiki: generic_string)
              else
                raise error
              end
            end

          else
            url = "https://en.wikipedia.org/wiki/#{actor['name'].gsub(' ', '_')}"
            begin
              doc = Nokogiri::HTML(open(url))
              text = doc.at_css('p').text
              @found_actor_from_api.create(name: actor['name'], actor_id: actor['id'], wiki: text)

            rescue OpenURI::HTTPError => error
              if error.message == '404 Not Found'

                Actor.create(name: actor['name'], actor_id: actor['id'], wiki: generic_string)
              else
                raise error
              end
            end
          end
        end
      end
    end
  end
end
