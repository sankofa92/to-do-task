class Task < ApplicationRecord
  include AASM
  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :tags, counter_cache: true
  
  validates :title, presence: true
  validates :content, presence: true

  enum status: { pending: 0, doing: 1, finish: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :doing, :finish

    event :take do
      transitions from: :pending, to: :doing
    end

    event :drop do
      transitions from: :doing, to: :finish
    end

  end
end
