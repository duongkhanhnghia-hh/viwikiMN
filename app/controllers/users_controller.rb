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
		@user_npq.each do |user| 
			@user_pq.push user
		end
		@user_pq.sort_by! { |m| m.id }
		@roles = Role.all
		@categories = Category.all
	end
	
	def edit
	end
	
	def chooseRole
	  @value = params[:data_value]
	  @users = User.all
	  @roles = Role.all
	  @value = @value[1,@value.length-2]
	  @arrvalue = Array.new
	  @arrvalue = @value.split(",")
	  @roleName = @arrvalue[1]
	  @roleId = @roleName
	  @roleName = @roleName[1,@roleName.length-2]
	  @user_id = @arrvalue[0]
	  if(@roleName == 'Admin')
	  	if !(@users.find(@user_id).roles.exists?(:name => "admin"))
	  		if @users.find(@user_id).roles.exists?(:name => "user")
				@users.find(@user_id).roles.destroy(@roles.find_by(name: 'user'))
			end
	  		@users.find(@user_id).roles.push @roles.find_by(name: 'admin')
	  		@users.find(@user_id).update(phanquyen: '1')
	  	end
	  elsif (@roleName == 'User')
	  	if !(@users.find(@user_id).roles.exists?(:name => "user"))
	  		@users.find(@user_id).roles.destroy(@users.find(@user_id).roles)
	  		@users.find(@user_id).roles.push @roles.find_by(name: 'user')
	  		@users.find(@user_id).update(phanquyen: '1')
	  	end
	  elsif (@roleName == 'None')
	  	@users.find(@user_id).roles.destroy(@users.find(@user_id).roles)
	  	@users.find(@user_id).update(phanquyen: '0')
	else
		if @users.find(@user_id).roles.exists?(:name => "user")
			@users.find(@user_id).roles.destroy(@roles.find_by(name: 'user'))
		end
		if !(@users.find(@user_id).roles.exists?(:id => @roleId.to_s))
			@users.find(@user_id).roles.push @roles.find(@roleId.to_s)
		else 
			@users.find(@user_id).roles.destroy(@roles.find(@roleId.to_s))
	   	@users.find(@user_id).update(phanquyen: '1')
	   end
	end
		  # if @arrvalue[2] == '0'
	  # 	@users.find(@arrvalue[0].to_s).roles.push @roles.find(@arrvalue[1].to_s)
	  # 	if 	@users.find(@arrvalue[0].to_s).phanquyen == false
	  # 		@users.find(@arrvalue[0].to_s).update(phanquyen: '1')
	  # 	end
	  # else
	  # 	@users.find(@arrvalue[0].to_s).roles.delete(@roles.find(@arrvalue[1].to_s))
	  # 	if @users.find(@arrvalue[0].to_s).roles.length == 0
	  # 		@users.find(@arrvalue[0].to_s).update(phanquyen: '0')
	  # 	end
	  # end
	end

	private
 
  	def checkadmin
    	unless policy(Category).admin?
      		flash[:error] = "You must be admin to access this section"
      		redirect_to '/'
   		end
  	end
end
