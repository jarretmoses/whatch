class RemoveGenreFromMovie < ActiveRecord::Migration
  def change
    remove_column :movies, :genre
  end
end
