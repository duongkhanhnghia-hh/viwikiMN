require "export_excel.rb"
require "import_excel.rb"

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
      while @category_tmp.parent_id != nil
        @category_tmp = @categoriesDB.find(@category_tmp.parent_id)
      end
      if @category_tmp.id == params[:id].to_i
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
    if scope == nil or @categories.empty?
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

  def create_newcomment
    @value = params[:data_value]
    @value = @value[1,@value.length-2]
    @arrvalue = Array.new
    @arrvalue = @value.split(',', 3)
    @arrvalue[1] = @arrvalue[1][1,@arrvalue[1].length-2]
    @arrvalue[2] = @arrvalue[2][1,@arrvalue[2].length-2]
    puts(@arrvalue[0])
    puts(@arrvalue[1])
    puts(@arrvalue[2])
    @comment = Comment.new
    @comment.body = "hello"
    @comment.resource_id = 1
    @comment.resource_type = @arrvalue[2]
    @comment.user_id = current_user.id
    @comment.save!
  end

  def details
      @category = Category.find(params[:id])  
      @description = Category.find(params[:id]).description    
      @post = Post.find_by(:category_id => params[:id])
      @comments = Comment.all
      @users = User.all
      @description_comment = Array.new
      @comments.each do |comment|
      if comment.resource_type == 'Description'
        @description_comment.push comment
      end
    end
  end

  def description
    @categories = Category.all
    @name = @categories.find(params[:id]).name
    @check =check_edit_description(params[:id])
    @description = @categories.find(params[:id]).description
    @comments = Comment.all
    @users = User.all
    @description_comment = Array.new
    @comments.each do |comment|
      if comment.resource_type == 'Description'
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

  def create
    @categories = Category.all
    @category = Category.new category_params
    @roles = Role.all
    @role = Role.new
    @role.name = 'editor'
    @role.resource_type = 'Category'
    @role.resource_id = @category.id
    @parent = @categories.find(@category.parent_id)
    @parent.children_count = @parent.children_count + 1 
    @role.save!
    @parent.save!
    authorize @category
    @category.save!
    

    filename = ExcelParser.exportData()
    flash[:error] = "You must have this role to access this section!"
      
    render :showall
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

    version = new Version
    version.

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
