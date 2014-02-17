require 'test_helper'

class PesosControllerTest < ActionController::TestCase
  setup do
    @peso = pesos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pesos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create peso" do
    assert_difference('Peso.count') do
      post :create, peso: {  }
    end

    assert_redirected_to peso_path(assigns(:peso))
  end

  test "should show peso" do
    get :show, id: @peso
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @peso
    assert_response :success
  end

  test "should update peso" do
    patch :update, id: @peso, peso: {  }
    assert_redirected_to peso_path(assigns(:peso))
  end

  test "should destroy peso" do
    assert_difference('Peso.count', -1) do
      delete :destroy, id: @peso
    end

    assert_redirected_to pesos_path
  end
end
