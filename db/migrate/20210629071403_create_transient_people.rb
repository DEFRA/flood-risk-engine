# frozen_string_literal: true

class CreateTransientPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :transient_people do |t|
      t.string :full_name
      t.belongs_to :transient_registration, index: true, foreign_key: true
    end
  end
end
