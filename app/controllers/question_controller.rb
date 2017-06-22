class QuestionController < ApplicationController

  def add_question
    @survey_id = params[:survey_id]
    @authenticity_token = params[:authenticity_token]
    @question = SurveyQuestion.new
  end

  def save_question
    @question = SurveyQuestion.new(question_params)
    if @question.save
      redirect_to :controller => 'survey', :action => 'show', :id => @question.survey_id
    else
      render 'add_question'
    end
  end

  def delete
    @question = SurveyQuestion.find(params[:id])
      if @question.delete
        redirect_to  :controller => 'survey', :action => 'show', id: params[:survey_id]
      end
  end

  private
  def question_params
    params.require(:survey_question).permit(:survey_id, :question_text, :question_type)
  end


end
