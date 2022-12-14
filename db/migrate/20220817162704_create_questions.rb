# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
