class OptionController < ApplicationController
  before_action :authenticate_user!

  attr_accessor :option_text

  def self.saveOptions (options = {}, question_id = 0)

    # @question = SurveyQuestion.find(question_id)
    # @option = @question.question_options.build(option_text: options)
    # @option.save

    @options = []
    options.each_with_index do |option, select_option_value|
      opt = QuestionOption.create(:select_option_value=>select_option_value+1 , :option_text => option, :survey_question_id => question_id)
      opt.save

    end
  end


end
