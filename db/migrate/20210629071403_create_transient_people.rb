# frozen_string_literal: true

class CreateTransientPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :transient_people do |t|
      t.string :full_name
      t.string :temp_postcode
      t.belongs_to :transient_registration, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
