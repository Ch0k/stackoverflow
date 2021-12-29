class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :links, dependent: :destroy, as: :linkable
  has_many :votes, dependent: :destroy, as: :votable
  has_many :unvotes, dependent: :destroy, as: :unvotable


  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true, length: { minimum: 15 }

  def voted?(user)
    self.votes.where(user_id: user.id).count >= 1
  end

  def unvoted?(user)
    self.unvotes.where(user_id: user.id).count >= 1
  end
end
