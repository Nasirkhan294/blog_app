class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can %i[index show], User
    can %i[new create show index], Post
    can %i[new create show index], Comment
    can %i[update destroy], Post, { author_id: user.id }
    can %i[update destroy], Comment, { author_id: user.id }
    can :manage, Post if user.is? :admin
    can :manage, Comment if user.is? :admin
  end
end
