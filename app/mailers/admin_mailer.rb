class AdminMailer < ActionMailer::Base
  default from: "noreply@example.com"
  default to: "shafi.tokhi@gmail.com"

  def mandrill_client
  	@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  	
  end
  def new_user(user)
  	@user = user
  	mail(subject: "New User: #{user.email}")
  end

  def send_notification
  	AdminMailer.new_user(self).deliver  	
  end

  def weekly_recipes(recipes)

  	template_name = 'new-reciepe'
  	template_content = []
  	message = {
  		to: [{email: "shafi.tokhi@gmail.com"}],
  		subject: "test subject",
  		merge_vars: [
  			{rcpt: "shafi.tokhi@gmail.com",
  				vars: [
  					{name: "", content: ""}
  				]

  			}

  		]
  	}
  	mandrill_client.messages.send_template template_name, template_content, message
  	
  end
end
