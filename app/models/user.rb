class User < ApplicationRecord
  has_many :tasks

  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }, uniqueness: { case_sensitive: false }
end