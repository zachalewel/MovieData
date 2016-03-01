class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :production_year

      t.timestamps null: false
    end
  end
end
