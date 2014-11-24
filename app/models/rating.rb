class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  has_many   :genres, through: :movie
end
