class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only => :destroy
	
	helper_method :sort_column, :sort_direction  
	
	def index
    @title = "All users"
    @users = User.order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])  
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.login
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	@user.reset_perishable_token!
    	UserMailer.activation_email(@user).deliver 
			flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
   		redirect_to root_path
		else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @user = current_user
    @title = "Edit user"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
    	@title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

	def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
    
private
	
	def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end 
	
	def admin_user 
		redirect_to(root_path) unless current_user.admin?
	end
	
	def sort_column  
     User.column_names.include?(params[:sort]) ? params[:sort] : "login"  
  end  
    
  def sort_direction  
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc" 
  end
   
end
