class SurveyQuestion < ApplicationRecord

  validates :question_text, presence: true
  validates :question_type, presence: true
end
