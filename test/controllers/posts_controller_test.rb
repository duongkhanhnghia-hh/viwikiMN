require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  def post
    @post ||= posts :one
  end

  def test_index
    get posts_url
    assert_response :success
  end

  def test_new
    get new_post_url
    assert_response :success
  end

  def test_create
    assert_difference "Post.count" do
      post posts_url, params: { post: { body: post.body, category_id: post.category_id, title: post.title, user_id: post.user_id } }
    end

    assert_redirected_to post_path(Post.last)
  end

  def test_show
    get post_url(post)
    assert_response :success
  end

  def test_edit
    get edit_post_url(post)
    assert_response :success
  end

  def test_update
    patch post_url(post), params: { post: { body: post.body, category_id: post.category_id, title: post.title, user_id: post.user_id } }
    assert_redirected_to post_path(post)
  end

  def test_destroy
    assert_difference "Post.count", -1  do
      delete post_url(post)
    end

    assert_redirected_to posts_path
  end
end
