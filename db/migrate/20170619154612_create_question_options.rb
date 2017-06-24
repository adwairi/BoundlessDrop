class CreateQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_options do |t|
      t.integer :select_option_value
      t.integer :survey_question_id
      t.string :option_text
      t.timestamps
    end
  end
end
