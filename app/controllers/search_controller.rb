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
    order = params[:order]
    genre = params[:genre]
    budget = params[:budget]


    #debug
    # puts "latitude: #{latitude.inspect}"
    # puts "longitude: #{longitude.inspect}"
    # puts "range: #{range.inspect}"
    # puts "page: #{page.inspect}"
    
    client = HotpepperClient.new(latitude, longitude)
    @shops = client.search_shops(latitude, longitude, range, order, genre, budget)
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
    when "3", ""
      @range = '1km'
    when "4"
      @range = '2km'
    when "5"
      @range = '3km'
    end

    case order
    when ""
      @order = '距離順'
    when "4"
      @order = 'オススメ順'
    end

    case genre
    when "G001"
      @genre = '居酒屋'
    when "G002"
      @genre = 'ダイニングバー・バル'
    when "G003"
      @genre = '創作料理'
    when "G004"
      @genre = '和食'
    when "G005"
      @genre = '洋食'
    when "G006"
      @genre = 'イタリアン・フレンチ'
    when "G007"
      @genre = '中華'
    when "G008"
      @genre = '焼肉・ホルモン'
    when "G017"
      @genre = '韓国料理'
    when "G009"
      @genre = 'アジア・エスニック料理'
    when "G010"
      @genre = '各国料理'
    when "G011"
      @genre = 'カラオケ・パーティ'
    when "G012"
      @genre = 'バー・カクテル'
    when "G013"
      @genre = 'ラーメン'
    when "G016"
      @genre = 'お好み焼き・もんじゃ'
    when "G014"
      @genre = 'カフェ・スイーツ'
    when "G015"
      @genre = 'その他グルメ'
    end


    case budget
    when ""
      @budget = '指定なし'
    when "B009"
      @budget = '～500円'
    when "B010"
      @budget = '501円～1,000円'
    when "B011"
      @budget = '1,001円～1,500円'
    when "B001"
      @budget = '1,501円～2,000円'
    when "B002"
      @budget = '2,001円～3,000円'
    when "B003"
      @budget = '3,001円～4,000円'
    when "B008"
      @budget = '4,001円～5,000円'
    when "B004"
      @budget = '5,001円～7,000円'
    when "B005"
      @budget = '7,001円～10,000円'
    when "B006"
      @budget = '10,001円～15,000円'
    when "B012"
      @budget = '15,001円～20,000円'
    when "B013"
      @budget = '20,001円～30,000円'
    when "B014"
      @budget = '30,001円～'
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