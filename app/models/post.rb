class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :body, presence: true
	validates :title, presence: true

	has_attached_file :picture, styles: { medium: "600x400>", thumb: "400x200>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
end
