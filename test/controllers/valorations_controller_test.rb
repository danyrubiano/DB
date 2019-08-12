require 'test_helper'

class ValorationsControllerTest < ActionController::TestCase
  setup do
    @valoration = valorations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:valorations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create valoration" do
    assert_difference('Valoration.count') do
      post :create, valoration: { calificacion: @valoration.calificacion, post_id: @valoration.post_id, user_id: @valoration.user_id }
    end

    assert_redirected_to valoration_path(assigns(:valoration))
  end

  test "should show valoration" do
    get :show, id: @valoration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @valoration
    assert_response :success
  end

  test "should update valoration" do
    patch :update, id: @valoration, valoration: { calificacion: @valoration.calificacion, post_id: @valoration.post_id, user_id: @valoration.user_id }
    assert_redirected_to valoration_path(assigns(:valoration))
  end

  test "should destroy valoration" do
    assert_difference('Valoration.count', -1) do
      delete :destroy, id: @valoration
    end

    assert_redirected_to valorations_path
  end
end
