require_dependency File.dirname(__FILE__) + '/block_add_blocks_block'

class BlockAddBlocksPlugin < Noosfero::Plugin

  def self.plugin_name
    "Block Add Blocks"
  end

  def self.plugin_description
    _("A plugin that adds a blocks.")
  end

  def self.extra_blocks
    {
      BlockAddBlocksBlock => {}
    }
  end

  def self.has_admin_url?
    false
  end

  #FIXME make this test
  def stylesheet?
    true
  end

  def js_files
    ['/javascripts/jstree/_lib/jquery-1.8.3.js', '/javascripts/jstree/jquery.jstree.js']
  end

end
