class SurveyController < ApplicationController
  def index
    @surveys = Survey.all  #find_by('user_id': current_user.id)
  end
  def new
    @survey = Survey.new
  end

  def edit
  end

  def delete
  end

  def show
  end
end
