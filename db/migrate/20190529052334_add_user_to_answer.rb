# frozen_string_literal: true

class AddUserToAnswer < ActiveRecord::Migration[5.2]
  def change
    change_table :answers do |t|
      t.references :user
    end
  end
end
