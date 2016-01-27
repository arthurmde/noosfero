class ProfileSearchBlock < Block

  def self.description
    _('Display a form to search the profile')
  end

  def content(args={})
    title = self.title
    subtitle = self.subtitle
    lambda do |_|
      render :file => 'blocks/profile_search', :locals => {
        :title => title,
        :subtitle => subtitle
      }
    end
  end

end
