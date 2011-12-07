class HomeController < ApplicationController
 skip_before_filter :authorize, :only => [:index, :login]

  def index
    #if it is logged in we will go to the main view page
    if @is_logged_in
          redirect_to view_table_view_path
    else
      	#@users = User.all
        end
  end

  def login
        logger.debug "login starts here:"
        email = params["email"]
    	psswd = params["password"]
        #fetch user interface by composite key find method
        @user = User.find(:first, :conditions=>["email=? AND password=MD5(?)", email, email+psswd])
        if @user.nil?
                logger.debug "No user object find, return to index"
                flash[:error] = "username and password are incorrect"
                redirect_to :action => "index"
        else
                logger.debug "fetch the user object and render the view"
                flash[:error] = nil
                #set login user object in session array 
                store_user_in_session # this method is defined in parent class application_controller
                #redirect you to the corresponding view
                flash[:notice] = 'you are authorized'
                redirect_to view_table_view_path
        end
  end

  def logout
    #destroy the session
    destroy_user_in_session
    logger.debug "user has been logged out"
    redirect_to '/home/index'
  end

  
 
	
  def profile
  end
	
  def upload
	logger.debug "upload is called"
  end
	

end
