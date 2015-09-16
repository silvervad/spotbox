class Spot < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [ :slugged, :history ]
  #after_initialize :set_seasons
  belongs_to :country
  has_many :schools
  has_many :photos, as: :imageable, dependent: :destroy
  
  has_many :seasons
  has_many :sports, through: :seasons
  
  accepts_nested_attributes_for :photos, :sports
  accepts_nested_attributes_for :seasons, :reject_if => :check_season_empty, :allow_destroy => true
  
  def check_season_empty(attributes)
    exists = attributes['id'].present?
    empty = attributes[:months].blank?
    attributes.merge!({:_destroy => 1}) if exists and empty
    return (!exists and empty)
  end


  def should_generate_new_friendly_id?
     name_changed?
  end
  
  
end
