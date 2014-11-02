class AdminMailer < ActionMailer::Base
  default from: "noreply@example.com"
  default to: "shafi.tokhi@gmail.com"

  def new_client
  	@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  	
  end
  def new_user(user)
  	@user = user
  	mail(subject: "New User: #{user.email}")
  end

  def send_notification
  	AdminMailer.new_user(self).deliver  	
  end

  def new_recipe(recipe)

  	
  end
end
