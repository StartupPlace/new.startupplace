class News < ActiveRecord::Base
	extend FriendlyId
  	
  	friendly_id :title, use: :slugged

	has_many :taggings
	has_many :tags, through: :taggings
	has_attached_file :image, styles: { medium: "600x300>", thumb: "240x120>" }

	def tag_list
	  tags.join(", ")
	end

	def tag_list=(tags_string)
		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
		new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  		self.tags = new_or_found_tags
	end

	def should_generate_new_friendly_id?
	  slug.blank? || title_changed?
	end
end
