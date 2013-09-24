class SocialBlock < Block


	settings_items :url, :type => :string, :default => ""

	def is_facebook?
		false

		if url.include?("facebook.com")
			true
		end
	end

	def is_twitter?
		false

		if url.include?("twitter.com")	
			true
		end
	end

	def is_gplus?
		false

		if url.include?("plus.google.com")
			true
		end
	end

	def is_linkedin?
		false

		if url.include?("linkedin.com")
			true
		end
	end

	def self.description
		_('Add Social')
	end

	def help
		_('This block presents a social block')
	end

	def content (args = {})
		block = self

		lambda do 
			render :file => 'blocks/social_block', :locals => { :block => block }
		end
	end

	def cacheable?
		false
	end
end
