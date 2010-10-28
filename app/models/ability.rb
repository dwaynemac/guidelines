class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :all
    cannot :read, [User, Federation]

    if user.role == "federation_president" || user.role == "federation_responsable"
      # goal
      can :create, Goal
      can :update, Goal, :institution_id => user.institution_id

      # followup
      can :manage, Followup, :goal => {:institution_id => user.institution_id}

      # person
      can [:update, :delete], Person, :institution_id => user.institution_id

      # aktion
      can :manage, Aktion do |aktion|
        aktion.try(:goal).try(:institution_id) == user.institution_id
      end
    end

    if user.role == "supervisor"
      can :see, :year_plan
    end

    if user.role == "admin"
      can :manage, :all
    end

  end

end