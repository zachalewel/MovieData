class Actor < ActiveRecord::Base
  belongs_to :movie
  validates :actor_id, presence: true, uniqueness: true

  def self.get_list_of_movie_actors
    Scrape::ActorsTextScrapeController.get_actors_text
  end
end
