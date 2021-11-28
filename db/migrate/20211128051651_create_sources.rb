class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :title, null: false
      t.integer :grade_id, null: false
      t.integer :subject_id, null: false
      t.integer :course_id, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
