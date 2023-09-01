class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all
    can :manage, Post, author: user
    can :manage, Comment, author: user
    can :manage, :all if user.is? :admin
  end
end
