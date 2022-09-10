class User < ApplicationRecord
  attr_accessor :old_password
  has_secure_password validations: false

  validate :password_presence
  validates :password, confirmation: true, allow_blank: true, length:{minimum: 8, maximum: 70}
  validate :password_complexity
  validate :correct_old_password, on: :update, if: ->{password.present?}

  validates :email, presence: true, uniqueness: true

  private

  def password_complexity
    return if password.blank? || password =~/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, 'Complexity requirement ...'
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
  end

end
