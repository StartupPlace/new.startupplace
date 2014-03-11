class News < ActiveRecord::Base
	extend FriendlyId
  	
  friendly_id :title, use: :slugged

  belongs_to :user
	has_many :taggings
	has_many :tags, through: :taggings
	has_attached_file :image, styles: { medium: "700x350>", thumb: "300x150>", square: "100x50"}

	validates :title, uniqueness: true, length: {
    minimum: 2,
    maximum: 50,
    tokenizer: lambda { |str| str.scan(/\w+/) },
    too_short: "must have at least %{count} words",
    too_long: "must have at most %{count} words"
  }
  validates :body, presence: true
  validates :tag_list, presence: true
	# Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

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
