class Goal < ActiveRecord::Base

  named_scope:visible_for, lambda { |user|
    unless %W(admin supervisor).include?(user.role)
      {:conditions => ["institution_id is null or institution_id = ?", user.institution.id]} unless user.institution.nil?
    end }

  acts_as_tree(:foreign_key => :goal_id, :order => :order_number)

  validates_numericality_of(:order_number)
  validates_presence_of :objective, :value, :control_item, :due_on

  belongs_to :goal
  belongs_to :responsable, :class_name => "Person"
  belongs_to :institution, :class_name => "Federation"
  
  has_many(:aktions)
  has_many(:goals)
  has_many(:followups)

  validate :or_goals_or_actions

  def id_number
    self.ancestors_and_self.map{|g|g.order_number}.join('.')
  end

  private
  def or_goals_or_actions
    if !self.goals.empty? && !self.aktions.empty?
      self.errors.add_to_base t('goal.validations.goals_or_actions')
    end
  end
end
