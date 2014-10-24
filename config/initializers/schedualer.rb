require 'rufus-scheduler'
require 'nokogiri'
require 'open-uri'

scheduler = Rufus::Scheduler.new

scheduler.every '20h' do
  puts "do something in every 15 seconds.."
  scrap_foodily
end

def scrap_foodily
	site = 'http://www.foodily.com'
	keys = ["vegetarian","egg","easy","pizza","soup","german","european","seafood","spaghetti","grill","steak", "kebab","milk","yummy", "irani", "eastern", "western" , "delicious","chicken", "breakfast", "dinner", "lunch", "sheep", "fish", "potato","tomato", "oil", "cream", "ice", "drink", "sweet", "fat", "burger","asian","persian", "arabic"]
	keys.each do | key |
		foodily = Nokogiri::HTML(open(site+"/s/#{key}"))
		recipes = foodily.xpath('//*[@id="cards_inner"]')[0].children

		recipes.each do | recipe |
			#img = recipe.children[1].children[1].children[1].attributes["src"].text.strip
			begin
			recipe_url = site + recipe.attributes["link"].text

			rescue
				next
			end
			
			m_recipe = Nokogiri::HTML(open(recipe_url))

			origional_link = m_recipe.xpath('//*[@id="recipe"]/div[8]/div[4]/div/div/a/@href').text

			r = Recipe.where("url = '#{origional_link}'")
			if(!r.empty?)
				puts "already stored!!"
				next
			end

			title = m_recipe.xpath('//*[@id="recipe"]/div[8]/div[1]/div/div/h1').text
			img = m_recipe.xpath('//*[@id="recipe"]/div[8]/div[2]/div/div/div[2]/img/@src').text
			ing_size = m_recipe.xpath('//*[@id="recipe"]/div[8]/div[3]/div/div/div/div/p').count
			ingredients = ""

			puts "count value: #{ing_size}"

			i = 0
			while i < ing_size  do
			   ingredients += m_recipe.xpath('//*[@id="recipe"]/div[8]/div[3]/div/div/div/div/p')[i].text.strip+","
			   i +=1
			end

			


			tags_xpath = m_recipe.xpath('//*[@id="recipe"]/div[8]/div[1]/div/div/div[3]/a').children
			tags = ""
			tags_xpath.each do |t|
				tags+= "#{t},"
			end
			puts "~> #{title}\n"
			# puts "url:\n#{recipe_url}\n"
			# puts "img:\n#{img}\n"
			# puts "origional_link:\n#{origional_link}\n"
			# puts "ingredients:\n#{ingredients}"
			# puts "tags:\n#{tags}"
			# puts "\n\n"
			# save recipe to db
			save_recipe(title, img, ingredients, origional_link, tags)

		end
	end
	
end

def save_recipe(title, img, ingredients, origional_link, tags)
	# r = Recipe.where("url = '#{origional_link}'")
	# if(r.empty?)
		recipe = Recipe.new(title: title, creator: "bot", url: origional_link, ingredients: ingredients, tags: tags, image: img)
		recipe.save
		post = Recipe.save(img)
		puts "saved!"
	# else
	# 	puts "already stored.."
	# end

end