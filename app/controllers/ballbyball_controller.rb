require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'
require './lib/seo_page_content/ballbyball_seo_content.rb'
require './lib/seo_page_content/seo_page_content.rb'

class BallbyballController < ApplicationController
   
   def show
    unique_id =  params[:unique_id]
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
      request = CricApi::ProfessionalProfile.new().getResponseforBallbyBall(unique_id)
      @ballbyball = request[:ballbyball]
      @cricketScore = request[:cricketScore]
      set_seo_content
   end
  
   def set_seo_content
    seo_page_data SeoPageContent::BallbyballPageSeoData.new(@cricketScore['data']).content
   end

end
