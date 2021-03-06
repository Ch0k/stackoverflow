class Answer < ApplicationRecord
  include Votable

  belongs_to :question
  belongs_to :user
  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files

  has_many :comments, dependent: :destroy, as: :commentable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true, length: { minimum: 15 }
end
