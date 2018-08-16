require 'test_helper'

class WorkflowTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workflow_templates_index_url
    assert_response :success
  end

  test "should get show" do
    get workflow_templates_show_url
    assert_response :success
  end

  test "should get new" do
    get workflow_templates_new_url
    assert_response :success
  end

  test "should get edit" do
    get workflow_templates_edit_url
    assert_response :success
  end

  test "should get delete" do
    get workflow_templates_delete_url
    assert_response :success
  end

end
