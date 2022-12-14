# frozen_string_literal: true

class AddRememberTokenDigestToUsers < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def change
    add_column :users, :remember_token_digest, :string
  end
end
