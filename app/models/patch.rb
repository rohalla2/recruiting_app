class Patch < ActiveRecord::Base
  belongs_to :player
  validates_presence_of :name, :player_id
end
