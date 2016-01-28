require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  setup do
    @blog_1 = blogs(:blog_one)
    current_user = users(:user_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    #assert_includes @response.body, 'blogs'
  end

  test "should not get new but should redirect becaue no one is logged in" do
    get :new
    assert_response :found
  end

  test "should not get create but should redirect becaue no one is logged in" do
    get :create
    assert_response :found
  end

  test "should not get show" do
    get :show, {'urllink' => "blah-blah-fam"}
    assert_response :found
  end

  #test "should get show" do
  #  get :show, {'urllink' => "blah-blah"}, {'user_id' => 1}
  #  assert_response :success
  #end

end
