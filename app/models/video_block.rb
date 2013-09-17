class VideoBlock < Block

  def self.description
    _('Add Video')
  end

  def help
    _('This block presents a video block.')
  end

  def content(args={})
    lambda do
      render :file => 'blocks/login_block'
    end
  end

  def cacheable?
    false
  end

end
