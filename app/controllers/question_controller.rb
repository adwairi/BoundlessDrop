class QuestionController < ApplicationController
  before_action :authenticate_user!
  def add_question
    @survey_id = params[:survey_id]
    @authenticity_token = params[:authenticity_token]
    @question = SurveyQuestion.new
  end

  def save_question
    @question = SurveyQuestion.new(question_params)

    if @question.save
      if params[:type] != 1 && !params[:options].blank?
        @options = params[:options]
        @question_id = @question.id
        OptionController.saveOptions(@options, @question_id)
      end
      redirect_to :controller => 'survey', :action => 'show', :id => @question.survey_id
    else
      render 'add_question'
    end
  end

  def delete
    @question = SurveyQuestion.find(params[:id])
      if @question.delete
        @options = QuestionOption.where(:survey_question_id => params[:id])
        for option in @options
          option.delete
        end
        redirect_to  :controller => 'survey', :action => 'show', id: params[:survey_id]
      end
  end

  private
  def question_params
    params.require(:survey_question).permit(:survey_id, :question_text, :question_type)
  end


end
