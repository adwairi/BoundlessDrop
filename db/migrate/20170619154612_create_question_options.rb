class CreateQuestionOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_options do |t|
      t.integer :question_id
      t.string :option_text
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end
end
