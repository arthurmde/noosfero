class VideoBlock < Block

  settings_items :url, :type => :string, :default => ""

  def self.description
    _('Add Video')
  end

  def help
    _('This block presents a video block.')
  end

  def content(args={})
    lambda do
      rander :partial => 'blocks/video_block'
    end
  end

  def cacheable?
    false
  end

end
