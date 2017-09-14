require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def comment
    @comment ||= comments :one
  end

  def test_index
    get comments_url
    assert_response :success
  end

  def test_new
    get new_comment_url
    assert_response :success
  end

  def test_create
    assert_difference "Comment.count" do
      post comments_url, params: { comment: { body: comment.body, post_id: comment.post_id, user_id: comment.user_id } }
    end

    assert_redirected_to comment_path(Comment.last)
  end

  def test_show
    get comment_url(comment)
    assert_response :success
  end

  def test_edit
    get edit_comment_url(comment)
    assert_response :success
  end

  def test_update
    patch comment_url(comment), params: { comment: { body: comment.body, post_id: comment.post_id, user_id: comment.user_id } }
    assert_redirected_to comment_path(comment)
  end

  def test_destroy
    assert_difference "Comment.count", -1  do
      delete comment_url(comment)
    end

    assert_redirected_to comments_path
  end
end
