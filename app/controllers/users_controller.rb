class UsersController < ApplicationController
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
	  else
	  	@users.find(@arrvalue[0].to_s).roles.delete(@roles.find(@arrvalue[1].to_s))
	  end
	end
end
