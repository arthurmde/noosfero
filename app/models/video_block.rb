class VideoBlock < Block

  settings_items :url, :type => :string, :default => ""
  
  def is_youtube? 
    false

    if url.include?("youtube.com")
      true
    end
  end

  def is_vimeo? 
    false

    if url.include?("vimeo.com")
      true
    end
  end

  def format_embedded_video_url
    self.url.gsub("watch?v=", "v/")
  end


  def self.description
    _('Add Video')
  end

  def help
    _('This block presents a video block.')
  end

  def content(args={})
    block = self

    lambda do
      render :file => 'blocks/video_block', :locals => { :block => block }
    end
  end

  
  def cacheable?
    false
  end
  
end
