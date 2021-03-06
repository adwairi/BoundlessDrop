class SurveyController < ApplicationController
  before_action :authenticate_user!

  skip_before_filter :verify_authenticity_token
  def index
    @surveys = Survey.where('user_id': current_user.id)
  end

  def edit
  end

  def delete
    @survey = Survey.find(params[:id])
    if @survey.user_id == current_user.id
      if @survey.delete
        redirect_to survey_index_path
      end
    end
  end

  def show
    @survey = Survey.find(params[:id])
    @can_manage = false
    @can_publish = false
    if @survey.user_id == current_user.id && !@survey.published
      @can_manage = true
    end

    if !@survey.survey_questions.blank?
      @can_publish = true
    end

  end

  def add_survey
    @survey = Survey.new
  end

  def save_survey
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to :controller => 'question', :action => 'add_question', :survey_id => @survey.id, :authenticity_token => params[:authenticity_token]
    else
      render 'add_survey'
    end
  end

  def publish

      @survey = Survey.find(params[:survey_id])
      if @survey.user_id == current_user.id && !@survey.survey_questions.blank?
        @survey.published = true
        if @survey.save
          render :json => {status:true, html: survey_show_path + '/' +params[:survey_id] }
        else
          render :json => {status:flase}
        end
      end
  end

  def answers
    @answers = []
    @survey = Survey.find(params[:survey_id])
    @survey.survey_questions.each do |question|
      question.survey_answers.each do |answer|
        @x = answer.validator_key
        if !@answers.include?@x
          @answers.push(answer.validator_key)
        end
      end
    end
  end

  def answer_details
    @survey = Survey.find(params[:survey])
    @validator_key = params[:validator_key]
    @survey_answers = SurveyAnswer.where(:validator_key => params[:validator_key]).all


  end
  private
  def survey_params
    params[:survey][:user_id] = current_user.id
    params.require(:survey).permit(:survey_title, :survey_description, :user_id)
  end

end
