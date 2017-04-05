require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'
require './lib/seo_page_content/ballbyball_seo_content.rb'
require './lib/seo_page_content/seo_page_content.rb'
require 'ballbyball/ballbyball.rb'

class BallbyballController < ApplicationController
   
   def show
    match_id = permitted_params[:match_id]
    unique_id =  params[:unique_id]
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
    if match_id.present?
      @match_data = Ballbyball.new(CricApi::ProfessionalProfile.new().getResponseforBallbyBall(match_id), match_id)
      render "show"  
    else
      @match_data = Ballbyball.new(CricApi::ProfessionalProfile.new().getResponseforBallbyBall(unique_id), unique_id)  
    end
    set_seo_content if @match_data.present? && @match_data.matchScore.present?
   end
   
   # def index
    # unique_id = permitted_params[:match_id]
    # cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
    # @match_data = Ballbyball.new(CricApi::ProfessionalProfile.new().getResponseforBallbyBall(unique_id), unique_id)
    # @data = @match_data
    # set_seo_content if @match_data.present? && @match_data.matchScore.present?
#     
  # end
  
   def set_seo_content
    seo_page_data SeoPageContent::BallbyballPageSeoData.new(@match_data.matchScore).content
   end
   
   def permitted_params
    params.permit(:match_id)
   end

end
