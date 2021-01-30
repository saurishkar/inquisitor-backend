class CreateUpvotes < ActiveRecord::Migration[5.2]
  def change
    create_table :upvotes do |t|
      t.references  :source, polymorphic: true, null: false
      t.integer     :user_id, null: false
      t.boolean     :value, default: true
      t.timestamps
    end
  end
end
