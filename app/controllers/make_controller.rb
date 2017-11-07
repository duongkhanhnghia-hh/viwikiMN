class MakeController < ApplicationController
  def view
    @category = Category.find(params[:category_id]);
    @post = @category.posts.build;
    @post.user = current_user
  end
end
