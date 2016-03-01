class AddActorToMovie < ActiveRecord::Migration
  def change
    add_reference :movies, :actor, index: true, foreign_key: true
  end
end
