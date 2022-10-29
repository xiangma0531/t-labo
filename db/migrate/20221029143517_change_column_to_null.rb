class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :sources, :course_id, true
  end

  def down
    change_column_null :sources, :course_id, false
  end
end
