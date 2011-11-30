class AssignReviewController < ApplicationController
skip_before_filter :authorize, :only => [:index, :login]
def assign
     redirect_to '/home/view'
  end
end
