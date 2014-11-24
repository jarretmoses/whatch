class AddDefaultValueToRatingAttribute < ActiveRecord::Migration
  def change
    change_column :ratings, :watched, :boolean, default: false
  end
end
