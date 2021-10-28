class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: { minimum: 15 }
end
