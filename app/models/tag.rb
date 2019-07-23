class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks, counter_cache: true

  validates :name, uniqueness: true
end
