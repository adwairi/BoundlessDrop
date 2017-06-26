class CreateSurveyAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :survey_answers do |t|
      t.integer :survey_id
      t.integer :question_id
      t.string :answer
      t.timestamps
    end
  end
end
