# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer, Comment], user_id: user.id
    can :destroy, [Question, Answer], user_id: user.id

    can :destroy, ActiveStorage::Attachment do |resource|
      user.author_of?(resource.record)
    end

    can :destroy, Link do |resource|
      user.author_of?(resource.linkable)
    end

    can :best, Answer do |resource|
      user.author_of?(resource.question)
    end

    can [:vote, :unvote], [Question, Answer]
    cannot [:vote, :unvote], [Question, Answer], user_id: user.id
    can :revote, [Question, Answer] do |resource|
      resource.votes.find_by(user_id: user.id)
    end
  end
end
