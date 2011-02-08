# Role abilities
#
# In views use can? or cannot?. e.g.:
#   <% if can? :update, @article %>
#    <%= link_to "Edit", edit_article_path(@article) %>
#  <% end %>
#
# In controllers use authorize! e.g.:
#
#   def show
#     @article = Article.find(params[:id])
#     authorize! :read, @article
#   end
#
#   OR for standard validations (:read, :update, :destroy)
#
#   class ArticlesController < ApplicationController
#     load_and_authorize_resource
#
#      def show
#        # @article is already loaded and authorized
#      end
#   end
class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, :all
    cannot :read, [User, Federation, Person]
    can [:profile,:update], User, :id => user.id

    # Abilities for Federation president and vice-president. (e.g.: Edgardo)
    if user.role == "federation_president" || user.role == "federation_responsable"
      # goal
      can :create, Goal

      can :add_subgoals, Goal do |goal|
        goal.institution_id == user.institution_id || goal.goal.nil?
      end
      can :add_actions, Goal, :institution_id => user.institution_id
      can [:delete, :update], Goal, :institution_id => user.institution_id

      # followup
      can :manage, Followup, :goal => {:institution_id => user.institution_id}

      # person
      can [:update, :delete], Person, :institution_id => user.institution_id

      # aktion
      can :manage, Aktion do |aktion|
        aktion.try(:goal).try(:institution_id) == user.institution_id
      end
    end

    # Abilities for Supervisor role. (e.g.: Office).
    if user.role == "supervisor"
      can :read, Federation
      can :see, :year_plan
    end

    # Abilities for system administrator.
    if user.role == "admin"
      can :manage, :all
    end

  end

end