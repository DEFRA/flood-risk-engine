# frozen_string_literal: true

class CreateTransientRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :transient_registrations do |t|
      t.string :token
      t.string :workflow_state

      t.index :token, unique: true

      t.timestamps null: false
    end
  end
end
