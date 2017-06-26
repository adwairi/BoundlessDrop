class CreateSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_answers do |t|
      t.string :validator_key
      t.integer :survey_id
      t.integer :survey_question_id
      t.string :answer
      t.timestamps
    end
  end
end
