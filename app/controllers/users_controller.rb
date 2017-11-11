class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :checkadmin
	def index
		@users = User.all
		@cruser = current_user
		@user_pq = Array.new
		@user_npq = Array.new
		@users.each do |user| 
			if user.phanquyen
				@user_pq.push user
			else 
				@user_npq.push user
			end
		end
		@roles = Role.all
		@categories = Category.all
		
	end
	
	def edit
	end
	def action
	  @value = params[:data_value]
	  @users = User.all
	  @roles = Role.all
	  @value = @value[1,@value.length-2]
	  @arrvalue = Array.new
	  @arrvalue = @value.split(",")
	  if @arrvalue[2] == '0'
	  	@users.find(@arrvalue[0].to_s).roles.push @roles.find(@arrvalue[1].to_s)
	  	if 	@users.find(@arrvalue[0].to_s).phanquyen == false
	  		@users.find(@arrvalue[0].to_s).update(phanquyen: '1')
	  	end
	  else
	  	@users.find(@arrvalue[0].to_s).roles.delete(@roles.find(@arrvalue[1].to_s))
	  	if @users.find(@arrvalue[0].to_s).roles.length == 0
	  		@users.find(@arrvalue[0].to_s).update(phanquyen: '0')
	  	end
	  end
	end
	
	private
 
  	def checkadmin
    	unless policy(Category).admin?
      		flash[:error] = "You must be admin to access this section"
      		redirect_to '/'
   		end
  	end
end
