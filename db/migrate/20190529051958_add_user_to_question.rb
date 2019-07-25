# frozen_string_literal: true

class AddUserToQuestion < ActiveRecord::Migration[5.2]
  def change
    change_table :questions do |t|
      t.references :user
    end
  end
end
