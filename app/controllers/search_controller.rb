require 'net/http'
require_relative '../../lib/hotpepper_client'

class SearchController < ApplicationController

  def search
  end

  def shops
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    range = params[:range]
    page = params[:page] || 1

    #debug
    # puts "latitude: #{latitude.inspect}"
    # puts "longitude: #{longitude.inspect}"
    # puts "range: #{range.inspect}"
    # puts "page: #{page.inspect}"
    
    client = HotpepperClient.new(latitude, longitude)
    @shops = client.search_shops(latitude, longitude, range)
    if @shops.present?
      @shop_count = @shops.size
    else
      @shop_count = 0
    end

    @latitude = latitude
    @longitude = longitude
    @current_page = page

    case range
    when "1"
      @range = '300m'
    when "2"
      @range = '500m'
    when "3"
      @range = '1km'
    when "4"
      @range = '2km'
    when "5"
      @range = '3km'
    end

    # Kaminari ページング
    # 取得した店舗数が1店舗のみの場合は例外的に処理する。
    # 取得した店舗数が1店舗のみだと配列としてではなく単一のオブジェクトとして値が返ってくるため、同様に処理するとエラーが発生する。
    if @shops.size > 0
      if @shops.is_a?(Array)
        if @shops.size <= 10
          @shops = Kaminari.paginate_array(@shops).page(page)
        else
          @shops = Kaminari.paginate_array(@shops).page(page).per(10)
        end
      else
        @shop_count = 1
        @shops = Kaminari.paginate_array([@shops]).page(page)
      end
    end

    respond_to do |format|
      format.html # クライアントがHTMLを要求した場合、上記で作成したビューを表示
      format.json { render json: @shops } # クライアントがJSONを要求した場合は、JSON形式でデータを返す
    end
  end
end