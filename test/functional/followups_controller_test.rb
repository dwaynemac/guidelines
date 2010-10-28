require 'test_helper'

class FollowupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:followups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create followup" do
    assert_difference('Followup.count') do
      post :create, :followup => { }
    end

    assert_redirected_to followup_path(assigns(:followup))
  end

  test "should show followup" do
    get :show, :id => followups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => followups(:one).to_param
    assert_response :success
  end

  test "should update followup" do
    put :update, :id => followups(:one).to_param, :followup => { }
    assert_redirected_to followup_path(assigns(:followup))
  end

  test "should destroy followup" do
    assert_difference('Followup.count', -1) do
      delete :destroy, :id => followups(:one).to_param
    end

    assert_redirected_to followups_path
  end
end
