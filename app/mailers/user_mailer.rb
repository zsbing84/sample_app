class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"  
  default_url_options[:host] = "example.com" 
  
  def activation_email(user)  
  	@user = user 
  	@url = activate_url(user.perishable_token)
  	mail(:to => user.email,  :subject => "Activation Instructions")  
  end 
  
  def welcome_email(user)  
  	@user = user 
  	mail(:to => user.email,  :subject => "Welcome to My Awesome Site")  
  end 
  
private
	def activate_url(activation_code)
		"http://localhost:3000/activate/#{activation_code}"
	end
	
end
