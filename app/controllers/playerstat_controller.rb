require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'
require './lib/seo_page_content/playerStats_seo_content.rb'
require './lib/seo_page_content/seo_page_content.rb'

class PlayerstatController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)  
   # @playerStats = cricApires.jsonRead('./lib/cricket_api/json_data/playerStat.json')
    @playerStats = cricApires.playerStats(params[:pid]);
    set_seo_content
  end
  
  def set_seo_content
    seo_page_data SeoPageContent::PlayerStatsPageSeoData.new(@playerStats['data']).content
  end
   
end