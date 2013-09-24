class SocialBlock < Block


	settings_items :url, :type => :string, :default => ""
	settings_items :option, :type => :string, :default => "0"
	
	def self.description
		_('Add Social')
	end

	def help
		_('This block presents a social block')
	end

	def content (args = {})
		lambda do 
			render :file => 'blocks/social_block'
		end
	end

	def cacheable?
		false
	end
end
