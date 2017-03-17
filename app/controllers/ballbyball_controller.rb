require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'
require './lib/seo_page_content/ballbyball_seo_content.rb'
require './lib/seo_page_content/seo_page_content.rb'
require 'ballbyball/ballbyball.rb'

class BallbyballController < ApplicationController
   
   def show
    unique_id =  params[:unique_id]
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
      @data = Ballbyball.new(CricApi::ProfessionalProfile.new().getResponseforBallbyBall(unique_id))
      set_seo_content if @data.present? && @data.matchScore.present?
   end
  
   def set_seo_content
    seo_page_data SeoPageContent::BallbyballPageSeoData.new(@data.matchScore).content
   end

end
