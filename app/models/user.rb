class User < ApplicationRecord
  has_secure_password(validations: false)
  has_many :tasks, dependent: :destroy

  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }, uniqueness: { case_sensitive: false }
end