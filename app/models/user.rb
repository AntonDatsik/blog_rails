class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 30 }, uniqueness: true

	has_secure_password

	validates :password_digest, length: { minimum: 6 }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

  	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
  	end
  	private

  	def create_remember_token
      	self.remember_token = User.encrypt(User.new_remember_token)
    end
end
