module Abilities
  class User
    include CanCan::Ability

    def initialize(user)
      if user.activated?
        can    :manage, ::User, id: user.id
        can    :read, :all
        cannot :read, ::User
      end
    end
  end
end
