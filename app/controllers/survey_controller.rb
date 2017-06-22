class SurveyController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def index
    @surveys = Survey.where('user_id': current_user.id)
  end

  def edit
  end

  def delete
  end

  def show
    @survey = Survey.find(params[:id])
    if @survey.user_id == current_user.id
      @questions = SurveyQuestion.where('survey_id': params[:id])
    else
      redirect_to survey_index_path
    end
  end

  def add_survey
    @survey = Survey.new
  end

  def save_survey
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to :controller => 'question', :action => 'add_question', :survey_id => @survey.id
    else
      render 'add_survey'
    end
  end


  private
  def survey_params
    params[:survey][:user_id] = current_user.id
    params.require(:survey).permit(:survey_title, :survey_description, :user_id)
  end

end
