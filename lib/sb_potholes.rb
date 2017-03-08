require "sb_potholes/version"
require 'unirest'

module SbPotholes
  class Pothole
    attr_reader :status, :street_address, :type_of_service_request, :ward, :zip

    def initialize(hash)
      @status = hash["status"]
      @street_address = hash["street_address"]
      @type_of_service_request = hash["type_of_service_request"]
      @ward = hash["ward"]
      @zip = hash["zip"]
    end

    def self.all
      potholes_array = Unirest.get("https://data.cityofchicago.org/resource/787j-mys9.json").body
      convert_hashes_to_objects(potholes_array)
    end

    def self.search(search_term)
      potholes_array = Unirest.get("https://data.cityofchicago.org/resource/787j-mys9.json?$q=#{search_term}").body
      convert_hashes_to_objects(potholes_array)
    end

    private

    def self.convert_hashes_to_objects(array_of_hashes)
      potholes = []
      array_of_hashes.each do |pothole_hash|
        potholes << Pothole.new(pothole_hash)
      end
      potholes
    end
  end
end
