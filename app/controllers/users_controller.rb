class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :checkadmin, only: [:index]
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
	
	def show
  		@user = User.find(params[:id])
  		@role = @user.roles[0]
  		if(@role != nil)
  			@roleName = @role.name
  		else
  			@roleName = "None"
  		end
  		@versions = PaperTrail::Version.all
  		@histories = Array.new
  		@versions.each do |version|
			if(version.whodunnit.to_i == @user.id)
				if version.item_type == 'Post'
					@post = Post.find(version.item_id)
					version.item_id = @post.category.id
				elsif version.item_type == 'Comment'
					@comment = Comment.find(version.item_id)
					version.item_id = @comment.category.id
				else
					if !Category.exists?(version.item_id)
						version.item_id = -1
					else
						@detail = version.object.to_s
						@object = ""
						if @detail != ""
							@details = Array.new
							@details = @detail.split("\n")
							@name = @details[2].to_s[6..1000]
							@parent_id = @details[3].to_s.delete("parent_id: ").to_i
							if true
								if Category.exists?(@parent_id)
									@parent_name = Category.find(@parent_id).name
								else
									@parent_name = "NULL"
								end
								@time = @details[15].to_s[10..28]
								@object = "Tên: " + @name + " <br> " + "Thư mục cha: " + @parent_name + " <br> " + "Thời gian: " + @time;
								version.object= @object
							end
						end
					end
				end
					@histories.push version
				
				# @parent_name = Category.find(@parent_id).name
				# puts @parent_name
			end
  		end	
  		@histories.sort_by! { |m| m.created_at }.reverse!
  		feeds(@user)
  	end

	def edit
	end

	def feeds (user)
		@users = User.all
  		scopes = policy_scope(Category)
		@versions = PaperTrail::Version.all
		@count = 0
		@historiesFeeds = Array.new
		@addType
		@versions.each do |version|
		if version.item_type == 'Post'
					@post = Post.find(version.item_id)
					version.item_id = @post.category.id
					@addType = "bài viết ở chuyên mục"
				elsif version.item_type == 'Comment'
					@comment = Comment.find(version.item_id)
					version.item_id = @comment.category.id
					@addType = "bình luận ở chuyên mục"
				else
					if !Category.exists?(version.item_id)
						version.item_id = -1
					end
					@addType = "chuyên mục"
				end
				if(version.item_id != -1)
					scopes.each do |scope|
						if(scope.id == version.item_id)
							@detail = version.object.to_s
							if version.event == 'create'
								version.object = "Tạo" + " " + @addType + " "+ scope.name
							elsif version.event == 'update'
								version.object = "Chỉnh sửa" + " " + @addType + " "+ scope.name
							end
							@historiesFeeds.push version
						end
					end
				end
			end
			@historiesFeeds.sort_by! { |m| m.created_at }.reverse!
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
	   		@users.find(@user_id).update(phanquyen: '1')
		else 
			@users.find(@user_id).roles.destroy(@roles.find(@roleId.to_s))
	   	end
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

	private
 
  	def checkadmin
    	unless policy(Category).admin?
      		flash[:error] = "You must be admin to access this section"
      		redirect_to '/'
   		end
  	end

  	
end
