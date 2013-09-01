require 'test_helper'

class TicketPostsControllerTest < ActionController::TestCase
  setup do
    @ticket_post = ticket_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_post" do
    assert_difference('TicketPost.count') do
      post :create, ticket_post: {  }
    end

    assert_redirected_to ticket_post_path(assigns(:ticket_post))
  end

  test "should show ticket_post" do
    get :show, id: @ticket_post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket_post
    assert_response :success
  end

  test "should update ticket_post" do
    put :update, id: @ticket_post, ticket_post: {  }
    assert_redirected_to ticket_post_path(assigns(:ticket_post))
  end

  test "should destroy ticket_post" do
    assert_difference('TicketPost.count', -1) do
      delete :destroy, id: @ticket_post
    end

    assert_redirected_to ticket_posts_path
  end
end
