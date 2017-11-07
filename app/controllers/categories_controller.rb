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
      scope = Category.all
    end

    @categories = scope.nested_tree
  end

  def show

    scope = policy_scope(Category)
    @editable = scope != nil
    gon.editable = @editable
    if not scope
      scope = Category.all
    end

    @categories = scope.nested_tree
  end

  def showall
    scope = policy_scope(Category)
    @editable = scope != nil
    gon.editable = @editable
    if not scope
      scope = Category.all
    end

    @categories = scope.nested_tree
  end

  def create
    @category = Category.new category_params
    authorize @category
    @category.save!

    filename = ExcelParser.exportData()
    render :show
  end

  def update
    cat = Category.find(params[:id])
    authorize cat
    cat.update! category_params
  end

  def destroy
    cat = Category.find(params[:id])
    authorize cat
    cat.destroy!
  end

  def reparent
    cat = Category.find params[:id]
    authorize cat

    parent_id = params.require :parent_id
    parent_cat = Category.find parent_id

    cat.move_to_child_of parent_cat
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


end
