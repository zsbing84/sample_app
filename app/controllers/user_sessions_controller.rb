class UserSessionsController < ApplicationController

	def new  
	  @user_session = UserSession.new  
	end
	
	def create  
	  @user_session = UserSession.new(params[:user_session])  
	  if @user_session.save  
	    flash[:notice] = "Successfully signed in."  
	    redirect_back_or root_path 
	  else  
	    render :action => 'new'  
	  end  
	end
	
	def destroy  
	  @user_session = UserSession.find  
	  @user_session.destroy  
	  flash[:notice] = "Successfully signed out."  
	  redirect_to root_path  
	end 

end
