require 'httparty'
require 'nokogiri'

class HotpepperClient
  include HTTParty
  base_uri 'http://webservice.recruit.co.jp/hotpepper'
  default_params key: 'bbf73490070f6cf1', format: 'xml'

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def search(options = {})
    query = {
      lat: options[:lat],
      lng: options[:lng],
      range: options[:range],
      count: options[:count]
    }
    response = self.class.get('/gourmet/v1/', query: query)
    if response.success?
      xml = Nokogiri::XML(response.body)
      json = Hash.from_xml(xml.to_s).to_json
      return JSON.parse(json)['results']['shop']
    else
      raise response.response
    end
  end

  def search_shops(latitude, longitude, range)
    options = {
      lat: latitude,
      lng: longitude,
      range: range,
      count: 100
    }


    client = HotpepperClient.new(latitude, longitude)
    result = client.search(options)
    if result.nil?
      return []
    else
      return result
    end
  end
  
  def get_shop(shop_id)
    query = { id: shop_id }
    response = self.class.get('/gourmet/v1/', query: query)
  
    if response.success?
      json = Hash.from_xml(response.body).to_json
      result = JSON.parse(json)['results']['shop']
      if result.nil?
        return []
      else
        return result
      end
    else
      raise response.response
    end
  end
  
end
