require 'net/http'
require_relative '../../lib/hotpepper_client'

class SearchController < ApplicationController

  def search
  end

  def shops
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    range = params[:range]

    #debug
    puts "latitude: #{latitude.inspect}"
    puts "longitude: #{longitude.inspect}"
    puts "range: #{range.inspect}"
  
    client = HotpepperClient.new(latitude, longitude)
    @shops = client.search_shops(latitude, longitude, range)

    @latitude = latitude
    @longitude = longitude
    @range = range

    respond_to do |format|
      format.html # クライアントがHTMLを要求した場合、上記で作成したビューを表示
      format.json { render json: @shops } # クライアントがJSONを要求した場合は、JSON形式でデータを返す
    end

    # debug
    # client = HotpepperClient.new(latitude, longitude)
    # puts "取得店舗情報...""
    # @shops = client.search_shops(latitude, longitude)
  end
end