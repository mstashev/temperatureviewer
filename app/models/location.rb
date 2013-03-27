require 'httparty'
require 'open-uri'
require 'json'

class Location < ActiveRecord::Base
  attr_accessible :city, :lat, :lon, :state, :temp_f, :zip
  attr_accessor :temp_f
  validates :zip, :presence => true


def get_geolookup(zip_code)
  open("http://api.wunderground.com/api/26c5e04f41912327/geolookup/q/#{zip_code}.json") do |f|
    json_string = f.read
    parsed_json = JSON.parse(json_string)
    self.city = parsed_json['location']['city']
    self.state = parsed_json['location']['state']
    self.lat = parsed_json['location']['lat']
    self.lon = parsed_json['location']['lon']
    self.zip = parsed_json['location']['zip']
  end
end

def get_current_conditions(zip_code)
  response = HTTParty.get("http://api.wunderground.com/api/26c5e04f41912327/geolookup/conditions/q/#{zip_code}.json")
  self.temp_f = response['current_observation']['temp_f']
end



end
