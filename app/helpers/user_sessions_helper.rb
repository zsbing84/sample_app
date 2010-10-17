module UserSessionsHelper

	def authenticate
    deny_access unless signed_in?
  end
  
  def deny_access
		store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def clear_return_to
    session[:return_to] = nil
  end

  def current_user_session  
	  return @current_user_session if defined?(@current_user_session)  
	  @current_user_session = UserSession.find  
	end  
	  
	def current_user  
	  @current_user = current_user_session && current_user_session.record  
	end
	
	def current_user?(user)  
	  current_user == user
	end
  
	def signed_in?
    !current_user.nil?
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to signin_path
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end
  
 end
