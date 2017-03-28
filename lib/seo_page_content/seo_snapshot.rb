=begin
  Important: This module will change in future when Hydra will get launched.
  Only thing that will change is from where we will read the data and minor tweaks around the JSON field names.
=end

module SeoPageContent
  class SeoSnapshot
    attr_accessor :title, :meta_description, :meta_keywords, :header_title, :intro, :section2, :section3, :end_para

    def initialize (source_file, geo_obj, agent_data = nil, params = {})
      @source_file = source_file
      @current_geo = geo_obj
      @seo_params  = params
      @agent_data  = agent_data
      set_data
    end

    private

    def set_data 
      if !@source_file.nil?
        json_source = File.read(Rails.root.join(@source_file))
        @hash_obj   = Hashie::Mash.new(JSON.parse(json_source))
        if !@hash_obj.Content.nil?
          set_page_title
          set_page_meta_description
          set_page_meta_keywords
          set_h1_tag
          set_page_intro
          set_page_section2
          set_page_section3
          set_page_end_para
        end
      end
    end

    def set_page_title
      if !@hash_obj.Content.Title.nil?
        set_meta_tags(@hash_obj.Content.Title, SEO_PAGE_TITLE_TAG)
      end
    end

    def set_page_meta_description
      if !@hash_obj.Content.MetaDescription.nil?
        set_meta_tags(@hash_obj.Content.MetaDescription, SEO_PAGE_META_DESCRIPTION)
      end
    end

    def set_page_meta_keywords
      if !@hash_obj.Content.MetaKeyword.nil?
        set_meta_tags(@hash_obj.Content.MetaKeyword, SEO_PAGE_META_KEYWORDS)
      end
    end

    def set_h1_tag
      if !@hash_obj.Content.H1.nil?
        set_meta_tags(@hash_obj.Content.H1, SEO_PAGE_HEADER_TAG)
      end
    end

    def set_page_intro
      if !@hash_obj.Content.Intro.nil?
        set_meta_tags(@hash_obj.Content.Intro, SEO_PAGE_INTRO_TAG)
      end
    end

    def set_page_section2
      if !@hash_obj.Content.Section2.nil?
        set_meta_tags(@hash_obj.Content.Section2, SEO_PAGE_SECTION2_TAG)
      end
    end

    def set_page_section3
      if !@hash_obj.Content.Section3.nil?
        set_meta_tags(@hash_obj.Content.Section3, SEO_PAGE_SECTION3_TAG)
      end
    end

    def set_page_end_para
      if !@hash_obj.Content.End.nil?
        set_meta_tags(@hash_obj.Content.End, SEO_PAGE_END_PARA_TAG)
      end
    end

    def set_meta_tags(meta_tag, tag_to_update)
      random_token = meta_tag.is_a?(Array) ? meta_tag.sample(1).first : meta_tag
      case tag_to_update
      when SEO_PAGE_TITLE_TAG
        @title = subsitute_defaults(random_token)
      when SEO_PAGE_META_DESCRIPTION
        @meta_description = subsitute_defaults(random_token)
      when SEO_PAGE_META_KEYWORDS
        @meta_keywords = subsitute_defaults(random_token)
      when SEO_PAGE_HEADER_TAG
        @header_title = subsitute_defaults(random_token)
      when SEO_PAGE_INTRO_TAG
        @intro = subsitute_defaults(random_token)
      when SEO_PAGE_SECTION2_TAG
        @section2 = subsitute_defaults(random_token)
      when SEO_PAGE_SECTION3_TAG
        @section3 = subsitute_defaults(random_token)
      when SEO_PAGE_END_PARA_TAG
        @end_para = subsitute_defaults(random_token)
      end
    end

    def subsitute_defaults(item)
      if @agent_data.present?
        if @agent_data['score'].present?
          item = item.gsub('[MATCHDETAIL]', @agent_data['score'])
        elsif @agent_data['fullName'].present?
          item = item.gsub('[MATCHDETAIL]', @agent_data['name'])
        elsif @agent_data['innings-requirement'].present?
          item = item.gsub('[MATCHDETAIL]', @agent_data['innings-requirement'])
        end
      end
      
      item
    end

  end
end
