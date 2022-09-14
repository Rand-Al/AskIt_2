# frozen_string_literal: true

class User < ApplicationRecord # rubocop:todo Style/Documentation
  attr_accessor :old_password, :remember_token

  has_secure_password validations: false

  validate :password_presence
  validates :password, confirmation: true, allow_blank: true, length: { minimum: 8, maximum: 70 }
  validate :password_complexity
  validate :correct_old_password, on: :update, if: -> { password.present? }

  validates :email, presence: true, uniqueness: true # rubocop:todo Rails/UniqueValidationWithoutIndex

  def remeber_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column :remember_token_digest, digest(remember_token) # rubocop:todo Rails/SkipsModelValidations
  end

  def forget_me
    update_column :remember_token_digest, nil # rubocop:todo Rails/SkipsModelValidations
  end

  def remember_token_authenticated?(remember_token)
    return false if remember_token_digest.blank?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'Complexity requirement ...'
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end
end
