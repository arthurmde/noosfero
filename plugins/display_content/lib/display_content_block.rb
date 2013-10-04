class DisplayContentBlock < Block

  settings_items :nodes, :type => Array, :default => []
  settings_items :parent_nodes, :type => Array, :default => []
  settings_items :chosen_attributes, :type => Array, :default => ['title']
  settings_items :item_count, :type => Integer, :default => 1
  settings_items :blog_picture, :type => :boolean, :default => false

  def self.description
    _('Display your contents')
  end

  def help
    _('This block displays articles chosen by you. You can edit the block to select which of your articles is going to be displayed in the block.')
  end

  def checked_nodes= params
    return self.nodes if self.holder.nil?
    articles = []
    parent_articles = []
    self.holder.articles.find(params.keys).map do |article|
      if article.folder?
        articles = articles + article.children
        parent_articles << article.id
      else
        articles<< article
      end
      parent_articles = parent_articles + get_parent(article) unless parent_articles.include?(article.parent_id)
    end
    self.parent_nodes = parent_articles
    self.nodes = articles.map{|a| a.id if a.is_a?(Event) || a.is_a?(TextArticle) }.compact
  end

  VALID_CONTENT = ['Event', 'RawHTMLArticle', 'TextArticle', 'TextileArticle', 'TinyMceArticle', 'Folder', 'Blog', 'Forum']

  def articles_of_parent(parent = nil)
    return [] if self.holder.nil?
    holder.articles.find(:all, :conditions => {:type => VALID_CONTENT, :parent_id => (parent.nil? ? nil : parent)}) 
  end

  include ActionController::UrlWriter
  def content(args={})
    docs = owner.articles.find(:all, :conditions => {:id => self.nodes})
    docs = docs.reverse
    docs = docs[0, self.item_count]
    block_title(title) +
    (self.blog_picture ? (self.parent_nodes.first.nil? ? '' : (Blog.find(self.parent_nodes.first).image.nil? ? '': image_tag(Blog.find(self.parent_nodes.first).image.public_filename()))) : '') +
     content_tag('ul', docs.map {|item|  
      content_tag('li', 
        (display_attribute?('title') ? link_to(h(item.title), item.url) : '') +
        (display_attribute?('abstract') ? item.abstract : '') +
        (display_attribute?('body') ? item.body : '') 
      )
    }.join("\n")) 
  end

  def footer
    #owner_id = owner.identifier
    #docs = owner.articles.find(:all, :conditions => {:id => self.nodes})
    #lambda do
    #  link_to s_('articles|View all'), :controller => 'search', :action => 'articles'
    #end
    return nil unless self.owner.is_a?(Profile)

    profile = self.owner
    lambda do
      link_to _('View All'), :profile => profile.identifier, :controller => 'content_viewer', :action => 'view_page', :page => 'blog'
    end
  end

  def url_params
    params = {:block_id => self.id}
    if self.owner.is_a?(Profile)
      params.merge!(:controller => "display_content_plugin_myprofile")
      params.merge!(:profile => self.holder.identifier)
    else
      params.merge!( :controller => "display_content_plugin_admin")
    end
    params
  end

  def display_attribute?(attr)
    chosen_attributes.include?(attr) 
  end

  protected

  def holder
    return nil if self.box.nil? || self.box.owner.nil?
    if self.box.owner.kind_of?(Environment) 
      return nil if self.box.owner.portal_community.nil?
      self.box.owner.portal_community
    else
      self.box.owner
    end
  end

  def get_parent(article)
    return [] if article.parent_id.nil?
    parents = [article.parent.id] + get_parent(article.parent)
    return parents
  end

end
