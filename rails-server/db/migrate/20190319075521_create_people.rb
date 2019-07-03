# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :imdb_id
      t.string :name
      t.boolean :director, default: false
      t.boolean :diva, default: false

      t.timestamps
    end
  end
end
