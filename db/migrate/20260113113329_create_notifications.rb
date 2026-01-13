class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :action
      t.datetime :read_at
      t.references :notifiable, polymorphic: true, null: false
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :actor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
