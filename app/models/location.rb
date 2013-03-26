class Location < ActiveRecord::Base
  attr_accessible :city, :lat, :lon, :state, :zip
end
