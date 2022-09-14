# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :body, presence: true, length: { minimum: 5 }
  belongs_to :question
end
