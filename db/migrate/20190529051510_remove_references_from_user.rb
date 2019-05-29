class RemoveReferencesFromUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :question_id
      t.remove :answer_id
    end
  end
end
