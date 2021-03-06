require "export_excel.rb"
require "import_excel.rb"
require 'pry'

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  include ExportExcel, ImportExcel

  def index
    scope = policy_scope(Category)
    @editable = scope != nil
    gon.editable = @editable
    if not scope
      flash[:error] = "You must have a role to access this section!"
      redirect_to '/'
    else
      @categories = scope.nested_tree
    end

  end

  def show
    scope = policy_scope(Category)
    @editable = scope != nil
    gon.editable = @editable
    @categoriesDB =Category.all
    @book_name = @categoriesDB.find(params[:id]).name
    @categories_tmp= Array.new
    if scope != nil 
      @categories = scope.nested_tree
      @categories.each do |scp|
        @category_tmp = scp[:node]
        puts @category_tmp.id.to_s + " " + params[:id].to_s
      while @category_tmp.parent_id != nil
        puts @category_tmp.id.to_s + " " + params[:id].to_s
        @category_tmp = @categoriesDB.find(@category_tmp.parent_id)
      end
      if  @category_tmp.id == params[:id].to_i
        @categories_tmp.push scp
      end
      end
      @categories = @categories_tmp
      @categories_list = Array.new
      @entries_list = Array.new
      @categories.each do |category|
      @categories_list.push category[:node].name
      @name_tmp = category[:node].name + " / "
      if not category[:children].empty?  
        category[:children].each do |n|  
          categories_list_simple(@categories_list, n, @name_tmp, @entries_list)
        end
      else
        @entries_list.push category[:node].name
      end 
    end
    @entries_list.sort_by! { |m| m }
    end
    # puts "================"
    # @cr_category = Category.find(params[:id])
    # @hasRole = false
    # @categoriesNT = scope.nested_tree
    # @categoriesNT.each do |scp|
    #   puts scp[:node].id.to_s + " " + @cr_category.id.to_s
    #   if scp[:node].id == @cr_category.id
    #     if @categories.empty?
    #         @categories.push scp
    #       end
    #     @hasRole = true
    #   end
    #   puts @hasRole
    #   while @cr_category.parent_id != nil
    #     @cr_category= @categoriesDB.find(@cr_category.parent_id)
    #   puts scp[:node].id.to_s + " " + @cr_category.id.to_s
    #     if scp[:node].id == @cr_category.id
    #       if @categories.empty?
    #         @categories.push scp
    #       end
    #       puts scp[:node].id
    #       @hasRole = true
    #       break
    #     end
    #   end
    # end
    # puts @hasRole
    if scope == nil or (@categories.empty? and !@hasRole)
      flash[:error] = "You must have this role to access this section!"
      redirect_to '/'
    end

  end

  def showall
    @categories = Category.all.nested_tree
    @categories_list = Array.new
    @entries_list = Array.new
    @categories.each do |category|
      @categories_list.push category[:node].name
      @name_tmp = category[:node].name + " / "
      if not category[:children].empty?  
        category[:children].each do |n|  
          categories_list_simple(@categories_list, n, @name_tmp, @entries_list)
        end
      else
        @entries_list.push category[:node].name
      end 
    end
    @entries_list.sort_by! { |m| m }
  end

  def categories_list_simple(categories_list, all_categories, name_tmp,entries_list)
    name_tmp += all_categories[:node].name
    categories_list.push name_tmp
    if not all_categories[:children].empty? 
      name_tmp += " / "
      all_categories[:children].each do |n|
        categories_list_simple(categories_list, n, name_tmp, entries_list)
      end 
    else
        @entries_list.push all_categories[:node].name
    end 
  end



  def details
      @category = Category.find(params[:id])  
      @description = Category.find(params[:id]).description    
      @post = Post.find_by(:category_id => params[:id])
      @comments = Comment.all
      @users = User.all
      @description_comment = Array.new
      @comments.each do |comment|
      #if comment.resource_type == 'Description'
        @description_comment.push comment
      #end
    end
  end

  


 def description
    @categories = Category.all
    @category = @categories.find(params[:id])
    @name = @category.name
    @check =check_edit_description(params[:id])
    @isEntry = (@category.children_count==0)
    @description = @category.description
    @comments = Comment.all
    @users = User.all
    @description_comment = Array.new
    @havePost = true
    if @isEntry
      @post = @category.post
      if @post == nil
        @havePost = false
      end
    end
    @comments.each do |comment|
      if comment.category_id == @category.id
        @description_comment.push comment
      end
    end
  end


  def edit__description

  end 

  def edit_description
    @value = params[:data_value]
    @value = @value[1,@value.length-2]
    @arrvalue = Array.new
    @arrvalue = @value.split(',', 2)
    @check = check_edit_description(@arrvalue[0].to_i)
    if(@check)
      @description = @arrvalue[1][1,@arrvalue[1].length-2]
      @categories = Category.all
      @categories.find(@arrvalue[0]).update(description: @description)
    end

  end

  def check_edit_description(description_id)
    scope = policy_scope(Category)
    if scope == nil
      return false
    end
    @categories_scope = scope.nested_tree
    @categories = Category.all
    @categories_scope.each do |category|
      @category_tmp = @categories.find(description_id)
      while (@category_tmp.parent_id != nil)
        if category[:node].id == @category_tmp.id
          return true
        end
        @category_tmp = @categories.find(@category_tmp.parent_id)
      end   
      if category[:node].id == @category_tmp.id
        return true
      end 
    end
    return false
  end

   def create_comment
    @comment_post = params[:data_value]
    @comment_post = @comment_post[1..(@comment_post.length-2)]
    @arrvalue = Array.new
    @arrvalue = @comment_post.split(',');
    @arrvalue[1] = @arrvalue[1][1..(@arrvalue[1].length-2)]
    if @arrvalue[1] != ""
      @comment = Comment.new
      @comment.category_id = @arrvalue[0]
      @comment.body = @arrvalue[1]
      @comment.user = current_user
      @comment.save!
    end

    # filename = ExcelParser.exportData()
    # flash[:error] = "You must have this role to access this section!"
      
    # render :description
  end

  def entry
    render "application/navbar"
  end

  def create_post

    @post_JS = params[:data_value]
    @post_JS = @post_JS[1..(@post_JS.length-2)]
    @arrvalue = Array.new
    @arrvalue = @post_JS.split(',');
    @arrvalue[1] = @arrvalue[1][1..(@arrvalue[1].length-2)]

    @arrvalue[2] = @arrvalue[2][1..(@arrvalue[2].length-2)]
    if @arrvalue[1] != ""
      if Post.exists?(category_id: @arrvalue[0])
        @post = Post.find_by(category_id: @arrvalue[0])
        puts @post
      else
        @post = Post.new
      end
      @post.category_id = @arrvalue[0]
      @post.body = @arrvalue[1]
      @post.title = @arrvalue[2]
      @post.user = current_user
      @post.save!
    end

    # filename = ExcelParser.exportData()
    # flash[:error] = "You must have this role to access this section!"
      
    # render :description
  end

  def create
    @categories = Category.all
    @category = Category.new category_params
    @parent = @categories.find(@category.parent_id)
    #binding.pry
    authorize @category
    @category.save!
    @category.move_to_child_of(@parent)
    @parent.children_count += 1;
    @parent.save!
    @roles = Role.all
    @role = Role.new
    @role.name = 'editor'
    @role.resource_type = 'Category'
    @role.resource_id = @category.id
    @role.save!
    

    # filename = ExcelParser.exportData()
    # flash[:error] = "You must have this role to access this section!"
      
    # render :showall

  end


  def update
    cat = Category.find(params[:id])
    authorize cat
    cat.update! category_params
  end

  def destroy
    @categories = Category.all
    cat = Category.find(params[:id])
    @parent = @categories.find(cat.parent_id)
    @parent.children_count = @parent.children_count - 1 
    @parent.save!
    authorize cat
    cat.destroy!
  end

  def reparent

    cat = Category.find params[:id]    
    authorize cat

    version = PaperTrail::Version.new
    version.item_type = "Category"
    version.item_id = params[:id]
    version.event = "update"
    version.whodunnit = current_user.id    
    version.object = "---\n" + "id: " + cat.name + "\nparent_id: " + cat.parent_id.to_s + "\nlft: " + cat.lft.to_s + "\nrgt: " + cat.rgt.to_s + "\ndescription: " + cat.description.to_s + "\ndepth: " + cat.depth.to_s + "\nchildren_count: " + cat.children_count.to_s+ "\ncreated_at: " + cat.created_at.to_s
    #version.object = cat.parent_id
    #+ "\nparent_id: " + cat.parent_id + "\nlft: " + cat.lft + "\nrgt: " + cat.rgt + "\ndescription: " + cat.description + "\ndepth: " + cat.depth + "\nchildren_count: " + cat.children_count
    version.save

    parent_id = params.require :parent_id
    parent_cat = Category.find parent_id
    cat.move_to_child_of parent_cat    
  end

  def undo
    version = Version.last
    
    @categories = Category.all
    cat = Category.order(updated_at: :desc).limit(1)
    @parent = @categories.find(cat.parent_id)
    @parent.children_count = @parent.children_count + 1
    @parent.save!
    authorize cat
    cat.destroy!
  end

  def export
    filename = ExportExcel.export_data
    send_file Rails.root.join('export', filename), :type=>"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet ", :x_sendfile=>true
    # render "export/export"
  end

  def import
    upload_file = params[:upload][:datafile]
    saved_file_path = Rails.root.join('uploads', upload_file.original_filename)

    File.open(saved_file_path, 'wb') do |file|
      file.write(upload_file.read)
    end

    ImportExcel.import_data(upload_file.original_filename)
    redirect_to action: :index
  end

  private
  def category_params
    params.permit(:name, :parent_id)
  end
  def find_root
    
  end

end
