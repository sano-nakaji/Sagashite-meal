require 'net/http'
require_relative '../../lib/hotpepper_client'

class SearchController < ApplicationController

  # def search
  #   if postal_code = params[:postal_code]
  #     params = URI.encode_www_form({zipcode: postal_code})
  #     uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")
  #     response = Net::HTTP.get_response(uri)
  #     result = JSON.parse(response.body)
  #     if result["results"]
  #       @zipcode = result["results"][0]["zipcode"]
  #       @address1 = result["results"][0]["address1"]
  #       @address2 = result["results"][0]["address2"]
  #       @address3 = result["results"][0]["address3"]
  #     end
  #   end
  # end

def shops
  latitude = params[:latitude].to_f #定数を入れると正常に動作する 35.4648064
  longitude = params[:longitude].to_f #133.070848
  
  client = HotpepperClient.new(latitude, longitude)
  @shops = client.search_shops(latitude, longitude)

  @latitude = latitude
  @longitude = longitude

  respond_to do |format|
    format.html # クライアントがHTMLを要求した場合、上記で作成したビューを表示
    format.json { render json: @shops } # クライアントがJSONを要求した場合は、JSON形式でデータを返す
  end

  # debug
  # client = HotpepperClient.new(latitude, longitude)
  # @shops = client.search_shops(latitude, longitude)
  # puts @shops.inspect
  end
end
