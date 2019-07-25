# frozen_string_literal: true

class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |u|
      u.string :api_key
    end
  end
end
