class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :title
      t.string :genre
      t.decimal :rating
      t.string :source_id
      t.string :poster

      t.timestamps null: false
    end
  end
end
