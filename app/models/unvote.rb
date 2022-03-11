class Unvote < ApplicationRecord
  belongs_to :unvotable, polymorphic: true
  belongs_to :user
end
