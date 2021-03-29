# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  first_name         :string
#  last_name          :string
#  email              :string
#  encrypted_password :string
#  salt               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  role               :integer          default("user")
#
class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/.freeze

  attr_accessor :password, :password_confirmation

  enum role: %I[user admin]

  has_many :sessions, dependent: :destroy

  validates :email, :first_name, :last_name, presence: true, if: -> { self.user? }
  validates :email,
            uniqueness: {
              case_sensitive: false,
              message: proc { "^#{I18n.t('errors.email_registered')}" }
            },
            format: {
              with: EMAIL_REGEXP,
              message: proc { "^#{I18n.t('errors.email_incorrect')}" }
            },
            length: { in: 6..48 }, presence: true, if: -> { email.present? }

  validates :password, presence: true, confirmation: true, length: { in: 6..48 }, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password? && :user?

  before_validation :downcase_email
  before_save :encrypt_password

  def authenticate?(password)
    encrypted_password == encrypt(password)
  end

  def info
    attributes.symbolize_keys.slice(:id, :first_name, :last_name, :email, :role, :created_at, :updated_at)
  end

  private

  def validate_password?
    new_record? && password.present? || password_confirmation.present?
  end

  def downcase_email
    email.downcase! if email.present?
  end

  def encrypt_password
    self.salt = make_salt if salt.blank?
    self.encrypted_password = encrypt(password) if password.present?
  end

  def encrypt(string)
    secure_hash("#{ string }--#{ salt }")
  end

  def make_salt
    SecureRandom.hex 32
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest string
  end
end
