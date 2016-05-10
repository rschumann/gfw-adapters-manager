module Abilities
  class AdminUser
    include CanCan::Ability

    def initialize(user)
      if user.activated?
        can :read, :all
        can :manage, ::User
        can [:edit_info, :update_info], ::User

        cannot :make_user,               ::User, id: user.id
        cannot [:activate, :deactivate], ::User, id: user.id
      end
    end
  end
end
