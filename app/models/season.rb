class Season < ActiveRecord::Base
  belongs_to :spot
  belongs_to :sport
end