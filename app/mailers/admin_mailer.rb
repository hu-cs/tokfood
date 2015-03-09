class AdminMailer < ActionMailer::Base
  default from: "noreply@gmail.com"

  def mandrill_client
  	# @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  	
  end
  def new_user(user)
  	@user = user
  	mail(to: @user.email, subject: "Welcome!")
  end



  def send_notification
  	AdminMailer.new_user(self).deliver  	
  end

  def weekly_recipes(recipes, users)
    @recipes = recipes
    emails = users.map {|user| user.email}
    mail(to: emails, subject: 'This week recipes', template_name: 'weekly_recipes')
  end

  # def weekly_recipes(recipes, users)

  # 	template_name = 'new-reciepe'
  # 	template_content = []
  #   users.each do | u |
  #   	message = {
  #   		to: [{email: u.email}],
  #   		subject: "Popular recipes by ",
  #   		merge_vars: [
  #   			{rcpt: u.email,
  #   				vars: [
  #   					{name: "IMAGE1", content: recipes[0].image},
  #             {name: "TITLE1", content: recipes[0].title},
  #             {name: "IMAGE2", content: recipes[1].image},
  #             {name: "TITLE2", content: recipes[1].title},
  #             {name: "IMAGE3", content: recipes[2].image},
  #             {name: "TITLE3", content: recipes[2].title},
  #             {name: "IMAGE4", content: recipes[3].image},
  #             {name: "TITLE4", content: recipes[3].title}
  #   				]

  #   			}

  #   		]
  #   	}
  #   	mandrill_client.messages.send_template template_name, template_content, message
  #   end
  	
  # end
end
