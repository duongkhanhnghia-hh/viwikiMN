require "test_helper"

class TodoControllerTest < ActionDispatch::IntegrationTest
  def test_new
    get todo_new_url
    assert_response :success
  end

end
