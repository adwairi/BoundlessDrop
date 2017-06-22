require 'test_helper'

class QuestionControllerTest < ActionDispatch::IntegrationTest
  test "should get add_question" do
    get question_add_question_url
    assert_response :success
  end

end
