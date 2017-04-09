require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class LiveScore

  attr_accessor :livescores, :livescore_by_type


  def initialize hash
    @details = Hashie::Mash.new(hash)
    build_detail_summary if @details.present?
  end

  private

  def build_detail_summary
    @livescores           = get_live_score
    @livescore_by_type    = get_score_by_type
  end

  def get_live_score
    @details 
  end
  
  def get_score_by_type    
    match_scores = @details
    match_ids = match_scores[:match_id]
    match_score_by_type = {}
    
    if match_scores.present? && match_ids.present?
      match_ids.each do |id|
       type = match_scores[id].data.type if match_scores[id].present? && match_scores[id].data.present? && match_scores[id].data.type.present?
       if type.present?
         match_score_by_type[type] = {} if !match_score_by_type[type].present? 
         match_score_by_type[type][id] = match_scores[id].data
       end  
      end
    end     
  end

end

