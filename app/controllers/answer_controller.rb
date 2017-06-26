class AnswerController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def show
    @survey = Survey.find(params[:survey])
  end

  def create
    @answers_param = params[:answer]
    @save_status = []
    @submitted_successfully = false
    if !@answers_param.blank?
      @answer_temp = @answers_param.first
      @answer_temp[1].each do |question|
        if question[1].strip != ''
          @answer = SurveyAnswer.new
          @answer.survey_id = @answer_temp[0]
          @answer.survey_question_id = question[0]
          @answer.answer = question[1]
          @answer.validator_key = DateTime.now.strftime('%Q')
          @save_status.push(@answer.save)
        end
      end
    end

    if !@save_status.include?false
      @submitted_successfully = true
      redirect_to :controller => 'home',:action => 'index', :success => @submitted_successfully
    end
  end


end
