class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.string :survey_title
      t.string :survey_description
      t.integer :user_id
      t.boolean :deleted, :default => false
      t.timestamps
    end
  end
end
