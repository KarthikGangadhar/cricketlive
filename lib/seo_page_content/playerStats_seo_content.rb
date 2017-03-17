require './lib/seo_page_content/seo_snapshot.rb'
module SeoPageContent
  class PlayerStatsPageSeoData
    attr_accessor :content

    def initialize (match_data)
      @match_data = match_data
      set_playerstats_seo_tags
    end

    private

    def set_playerstats_seo_tags
      @content = SeoPageContent::SeoSnapshot.new(source, nil, @match_data , {})
    end

    def source
      "lib/seo_configuration/playerstats/PlayerStats.json"
    end

  end

end
