module UsersHelper
	def medium_avatar_for(user)
		image_tag user.avatar.url(:medium)
	end

	def thumb_avatar_for(user)
		image_tag user.avatar.url(:thumb), :class => "img-circle"
	end
end
