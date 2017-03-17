require './lib/seo_page_content/seo_snapshot.rb'
module SeoPageContent
  class BallbyballPageSeoData
    attr_accessor :content

    def initialize (match_data)
      @match_data = match_data
      set_ballbyball_seo_tags
    end

    private

    def set_ballbyball_seo_tags
      @content = SeoPageContent::SeoSnapshot.new(source, nil, @match_data , {})
    end

    def source
      "lib/seo_configuration/ballbyball/ballbyball.json"
    end

  end

end
