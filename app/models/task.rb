class Task < ApplicationRecord
  # belongs_to :user
  has_and_belongs_to_many :tags
  
  validates :title, presence: true
  validates :content, presence: true

  enum status: { pending: 0, doing: 1, finish: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
end
