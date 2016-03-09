module PostsHelper
	def abbreviated_post(post)
		text = post.body
		result = text

		if text.length > 300
			result = text[0..300]
			result << '...'
		end

		result
	end
end
