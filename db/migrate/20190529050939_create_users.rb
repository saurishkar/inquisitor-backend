class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
    add_index :users, :email
  end
end
