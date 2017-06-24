class Survey < ApplicationRecord

  has_many :survey_questions, dependent: :destroy

  validates :survey_title, presence: true

end
