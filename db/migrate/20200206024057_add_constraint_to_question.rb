class AddConstraintToQuestion < ActiveRecord::Migration[5.2]
  def change
    change_column_null :questions, :user_id, false
  end
end
