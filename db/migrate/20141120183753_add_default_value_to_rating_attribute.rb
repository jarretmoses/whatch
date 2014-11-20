class AddDefaultValueToRatingAttribute < ActiveRecord::Migration
  def change
    change_column :ratings, :watched, :boolean, default: 0
  end
end
