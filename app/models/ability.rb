class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Group, :user_id => user.id
      can :manage, Contact, :user_id => user.id
    else
      can :create, User
    end
  end
end
