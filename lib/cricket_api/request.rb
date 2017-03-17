require 'httparty'
require 'json'

module CricApi
  class Request
    include HTTParty
    base_uri 'https://apecricket.herokuapp.com'
    def initialize(service, page)
      @options = { query: {site: service, page: page} }
    end

    def cricket
      self.class.get("/api/cricket", @options)
    end

    def matches
      self.class.get("/api/matches", @options)
    end

    def matchCalendar
      self.class.get("/api/matchCalendar", @options)
    end

    def getNews
      self.class.get("/api/news", @options)
    end

    def cricketScore(id)
      self.class.post("/api/cricketScore",
      :body => {
        :unique_id => id
      }
      )
    end

    def playerStats(id)
      self.class.post("/api/playerStats",
      :body => {
        :pid => id
      }
      )
    end

    def ballByball(id)
      self.class.post("/api/ballByBall",
      :body => {
        :unique_id => id
      }
      )
    end

    def commentry(id)
      self.class.post("/api/commentry",
      :body => {
        :unique_id => id
      }
      )
    end

    def news(id)
      self.class.post("/api/news",
      :body => {
        :unique_id => id
      }
      )
    end

    def score(id)
      self.class.post("/api/score",
      :body => {
        :unique_id => id
      }
      )
    end

    def getLiveScores

      updates = []
      scores =  cricket
      data = scores['data']['data']
      data.each do |match|
        updates.push(cricketScore(match['unique_id']))
      end

      return updates

    end

    def liveUpdates
      
      match_update = cricket 
      live_updates = matches
      
      live_updates['data']['matches'].each do |update|
        data = match_update['data']['data']
        # binding.pry
        for item in data 
          # binding.pry         
          if item['unique_id'] == update['unique_id']
            update['title'] = item['title']
            update['description'] = item['description']
            # binding.pry
          break;
          end
        end

      end
      return live_updates
    end

    def jsonRead(filename)
      file = File.read(filename)
      data_hash = JSON.parse(file)
      # file.close
      return data_hash
    end
    
    
    def match_ids
      match_update = cricket
      live_updates = matches
      unique_ids = match_update['data']['data'].collect{ |v| v['unique_id'] }
      all_matches = live_updates['data']['matches'].collect{ |v| v['unique_id']}
      ongng_match_ids = []
      remaining_match_ids = []
      all_matches.each do |id|
        matched = false
        unique_ids.each do |uid|
          if id == uid.to_i
          matched = true
          ongng_match_ids.push(uid.to_i)
          end
        end
        if !matched
        remaining_match_ids.push(id)
        end
      end

      match_ids = {
        "ongng_ids" => ongng_match_ids, 
        "remaining_ids" => remaining_match_ids 
      }
            
    end
    
    
    def match_response(ids)
      ongng_ids = ids['ongng_ids']
      new_ids = ids['remaining_ids']
      response = []
      new_resp = []
      
      # ongng_ids.each do |id|
      count = 0
      for id in ongng_ids
        count += 1 
        resp = cricketScore(id)
        response.push(resp['data'])
        
        if count >5
          count = 0
          break
        end
      end
      
      for id in new_ids
      # new_ids.each do |id|
        count += 1 
        if count >5
          break
        end
        resp = cricketScore(id)
        new_resp.push(resp['data'])
      end
      return {:ongng => response, :new_resp => new_resp }
    end

  end

end