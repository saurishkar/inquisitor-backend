# frozen_string_literal: true

class RemoveEncryptedPasswordFromUsers < ActiveRecord::Migration[5.2]
  def change
    # remove_column :users, :encrypted_password
  end
end
