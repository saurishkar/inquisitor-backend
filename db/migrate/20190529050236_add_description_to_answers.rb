class AddDescriptionToAnswers < ActiveRecord::Migration[5.2]
  def change
    change_table :answers do |t|
      t.index :description
    end
  end
end
