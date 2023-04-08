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
    # searchメソッドと同様、必要なパラメーターを設定
    query = {
      lat: options[:lat],
      lng: options[:lng],
      range: options[:range],
    }
    # HTTPartyを使用してAPIにリクエストを送信、レスポンスを取得
    response = self.class.get('/gourmet/v1/', query: query)

    if response.success?
      # レスポンスが成功した場合、XML形式のレスポンスをパースしてJSON形式に変換
      xml = Nokogiri::XML(response.body)
      json = Hash.from_xml(xml.to_s).to_json
      return JSON.parse(json)['results']['shop']
    else
      raise response.response
    end
  end

  def search_shops(latitude, longitude, range)
    # 必要なパラメーターを設定
    options = {
      lat: latitude,
      lng: longitude,
      range: range,
    }
    # searchメソッドを使用、APIから店舗情報を取得する
    result = search(options)
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
