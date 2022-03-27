class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  has_many :questions
  has_many :answers
  has_many :badges
  has_many :votes
  has_many :comments
  has_many :authorizations, dependent: :destroy

  
  def author_of?(object)
    object.user_id == self.id
  end

  def voted?(object)
    votes.exists?(votable: object)
  end

  def self.find_for_oauth(auth)
    FindForOauthService.new(auth).call
  end
end
