require File.dirname(__FILE__) + '/../test_helper'

class BlockAddBlocksPluginTest < ActiveSupport::TestCase

  should "add the jstree javascript" do
    plugin = BlockAddBlocksPlugin.new
    assert plugin.js_files.include?('/javascripts/jstree/jquery.jstree.js')
  end

  should "add new JQuery version" do
    plugin = BlockAddBlocksPlugin.new
    assert plugin.js_files.include?('/javascripts/jstree/_lib/jquery-1.8.3.js')
  end

  should "return BlockAddBlocksBlock in extra_mlocks class method" do
    assert  BlockAddBlocksPlugin.extra_blocks.keys.include?(BlockAddBlocksBlock)
  end

  should "return false for class method has_admin_url?" do
    assert  !BlockAddBlocksPlugin.has_admin_url?
  end

end
