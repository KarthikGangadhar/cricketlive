require 'typhoeus'
require './lib/cricket_api/request.rb'

module CricApi
  class ProfessionalProfile
    def initialize
      
    end

    

    def getResponseforHome                      
      api_requests = {
        :news => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/news",
                                method: :get,
                                headers: { 'ContentType' => "application/json/"}),
        :matchcalendar => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/matchCalendar",
                                method: :get,
                                headers: { 'ContentType' => "application/json"}),
        :cricket => Typhoeus::Request.new("https://apecricket.herokuapp.com/api/cricket",
                                method: :get,
                                headers: { 'ContentType' => "application/json"}),
        :matches => Typhoeus::Request.new("http://apecricket.herokuapp.com/api/matches",
                                method: :get,
                                headers: { 'ContentType' => "application/json"})
      }
      
      hydra = Typhoeus::Hydra.new(max_concurrency: api_requests.count) 
      
      requests = [:news,:matchcalendar,:cricket,:matches].each_with_object({}) do |type,hash_obj|
        hash_obj[type] = api_requests[type]
        hydra.queue(hash_obj[type])
      end
      
      hydra.run
      teamObj = {}
      
      responses = requests.each_with_object({}) do | (name, req) |
        teamObj[name] = JSON.parse(req.response.body)
      end
    
      return teamObj 
               
    end
    
def getResponseforBallbyBall(unique_id)                        
      api_requests = {
        :ballbyball => Typhoeus::Request.new("http://apecricket.herokuapp.com/api/ballByBall",
                                method: :post,
                                headers: { 'ContentType' => "application/json/"},
                                body: {unique_id: unique_id.to_s } ),
        :cricketScore => Typhoeus::Request.new("http://apecricket.herokuapp.com/api/cricketScore",
                                method: :post,
                                headers: { 'ContentType' => "application/json"},
                                body: {unique_id: unique_id.to_s } )
      }
      
      hydra = Typhoeus::Hydra.new(max_concurrency: api_requests.count) 
      
      requests = [:ballbyball,:cricketScore].each_with_object({}) do |type,hash_obj|
        hash_obj[type] = api_requests[type]
        hydra.queue(hash_obj[type])
      end
      
      hydra.run
      teamObj = {}
      
      responses = requests.each_with_object({}) do | (name, req) |
        if req.response.body.present?
        teamObj[name] = JSON.parse(req.response.body)
        end
      end
    
      return teamObj 
               
    end
    
    def getLiveUpdates(cricket , matches)
      crnt_mts = []
      upcmng_mts = []

      if matches['data']['matches'].present? && matches['data'].present? && matches['data']['matches'].present?
        mtc_data = matches['data']['matches']
        crnt_data = cricket['data']['data']
        
        current_mtc_ids = Hash[crnt_data.map { |c| [c['unique_id'], c] }]


        mtc_data.select { |h| current_mtc_ids.has_key?(h['unique_id'].to_s ) }
       .map { |h| [h, current_mtc_ids[h['unique_id']]] }
        
        return {
            :current => crnt_mts,
            :upcoming => upcmng_mts
        }
        
      end
    end


    def getAllScore(cricket)
        matches = cricket['data']['data']
        allScore = []
        unique_ids = matches.map { |m| m['unique_id']}
        api_requests = {}
        
        unique_ids.each do |id|
          api_requests[id] = Typhoeus::Request.new("http://apecricket.herokuapp.com/api/cricketScore",
                                method: :post,
                                headers: { 'ContentType' => "application/json/"},
                                body: {unique_id: id.to_s } )
        end
       
        
        hydra = Typhoeus::Hydra.new(max_concurrency: api_requests.count) 
      
        requests = unique_ids.each_with_object({}) do |type,hash_obj|
          hash_obj[type] = api_requests[type]
          hydra.queue(hash_obj[type])
        end
      
        hydra.run
        teamObj = {}
        responses = requests.each_with_object({}) do | (name, req) |
          teamObj[name] = JSON.parse(req.response.body)
        end
        return teamObj
            
    end 
   
   
   
   
   
  end
end
