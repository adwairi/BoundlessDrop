class SurveyQuestion < ApplicationRecord
  belongs_to :survey
  has_many :question_options, dependent: :destroy
  has_many :survey_answers, dependent: :destroy

  validates :question_text, presence: true
  validates :question_type, presence: true
end
