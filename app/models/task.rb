class Task < ApplicationRecord
  include AASM
  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :tags
  
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

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

end
