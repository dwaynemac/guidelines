require 'test_helper'

class FederationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:federations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create federation" do
    assert_difference('Federation.count') do
      post :create, :federation => { }
    end

    assert_redirected_to federation_path(assigns(:federation))
  end

  test "should show federation" do
    get :show, :id => federations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => federations(:one).to_param
    assert_response :success
  end

  test "should update federation" do
    put :update, :id => federations(:one).to_param, :federation => { }
    assert_redirected_to federation_path(assigns(:federation))
  end

  test "should destroy federation" do
    assert_difference('Federation.count', -1) do
      delete :destroy, :id => federations(:one).to_param
    end

    assert_redirected_to federations_path
  end
end
