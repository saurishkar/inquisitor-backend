# frozen_string_literal: true

class AddPasswordFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :password, default: '', null: false
    end
  end
end
