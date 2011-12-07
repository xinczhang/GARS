class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  layout 'main_layout'
  	
  protected
    def store_user_in_session
     # session[:current_user] = @user
      session[:current_user] = @user.id
	  session[:is_logged_in] = true
	  if @user.role == 0
	    session[:is_admin] = true
	  else
	    session[:is_admin] = false
	  end
	end
	
	def destroy_user_in_session
	  session[:current_user] = nil
    end
	
    def authorize
      if session[:current_user].nil?
	    flash[:error] = 'You are not authorized. Please log in first.'
        redirect_to home_index_path
      else

       # @user = session[:current_user]
        uid = session[:current_user]
	if session[:ay_display].nil?
		session[:ay_display] = "Institution1, Country of Citizenship".split
	end
	if session[:ots_display].nil?
		session[:ots_display] = "".split
	end
        @user = User.find_by_id(uid)
        @is_logged_in = session[:is_logged_in]
        @is_admin = session[:is_admin]
        @uname = @user.name
	  end
    end

end
