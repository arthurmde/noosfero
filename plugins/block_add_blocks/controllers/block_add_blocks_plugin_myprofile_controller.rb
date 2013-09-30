require File.dirname(__FILE__) + '/block_add_blocks_plugin_module'

class BlockAddBlocksPluginMyprofileController < MyProfileController

  append_view_path File.join(File.dirname(__FILE__) + '/../views')

  include BlockAddBlocksPluginController 

end
