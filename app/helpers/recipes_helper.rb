module RecipesHelper
	def vido_info(link)
	  @vido_info = VideoInfo.new(link)
	end
end
