class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :linkable, polymorphic: true

  validates :score, presence: true
  validates_numericality_of :score, only_integer: true
end
