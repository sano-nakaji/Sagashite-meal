require 'net/http'
require_relative '../../lib/hotpepper_client'

class ShopController < ApplicationController
  def show
    shop_id = params[:id]

    client = HotpepperClient.new(0,0)
    @shop = client.get_shop(shop_id)

    puts @shop.inspect

    respond_to do |format|
      format.html # クライアントがHTMLを要求した場合、上記で作成したビューを表示
      format.json { render json: @shops } # クライアントがJSONを要求した場合は、JSON形式でデータを返す
    end
  end
end
