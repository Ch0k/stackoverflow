class Answer < ApplicationRecord
  include HasVote
  include HasUnvote

  belongs_to :question
  belongs_to :user
  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true, length: { minimum: 15 }
end
