class AnswerController < ApplicationController

  def start
    @survey = Survey.find(params[:survey])
  end

  def create
    @answers_param = params[:answer]

    if !@answers_param.blank?
      @answer_temp = @answers_param.first
      @answer_temp[1].each do |question|
        if question[1].strip != ''
          @answer = SurveyAnswer.new
          @answer.survey_id = @answer_temp[0]
          @answer.question_id = question[0]
          @answer.answer = question[1]
          @answer.save
        end
      end
    end
  end

  def success
    @x = 'ssssssssssss'
  end

end
