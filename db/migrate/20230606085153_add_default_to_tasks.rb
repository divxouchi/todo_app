class AddDefaultToTasks < ActiveRecord::Migration[6.0]
  def up
    change_column_default :tasks, :completed, from: nil, to: false
  end

  def down
    change_column_default :tasks, :completed, from: false, to: nil
  end
end
