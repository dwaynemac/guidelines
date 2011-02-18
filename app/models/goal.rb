class Goal < ActiveRecord::Base

  before_validation :default_order

  named_scope :visible_for, lambda { |user|
    unless %W(admin supervisor).include?(user.role)
      {:conditions => ["institution_id is null or institution_id = ?", user.institution.id]} unless user.institution.nil?
    end }

  acts_as_tree(:foreign_key => :goal_id, :order => :order_number)

  validates_numericality_of(:order_number)
  validates_presence_of :objective, :value, :control_item, :due_on

  belongs_to :goal # parent goal
  belongs_to :responsable, :class_name => "Person"
  belongs_to :institution, :class_name => "Federation"
  
  has_many(:aktions, :dependent => :destroy)
  has_many(:goals, :dependent => :destroy)
  has_many(:followups, :dependent => :destroy)

  validate :either_goals_or_actions

  # TODO for larger databases id_number should be stored on DB
  def id_number
    self.ancestors_and_self.map{|g|g.order_number}.join('.')
  end

  # Returns sum of values grouped by children control_item
  # All of these values are considered to be implicit on this goal.
  #
  # @return [OrderedHash] keys are control_item, values are subtotal values
  # @return_example {"teacher" => 10, "students" => 5}
  def implicit_goals
    self.goals.sum(:value, :group => :control_item)
  end

  INCIDENCE_NAMES = {1 => I18n.t('goals.year_plan.low'),2 => I18n.t('goals.year_plan.medium'),3 => I18n.t('goals.year_plan.strong')}

  # sets attribute incidence according to string
  # @argument [String] incidence name
  # @return incidence number
  def incidence_name=(string)
    INCIDENCE_NAMES.invert[string]
  end

  # @return [String] incidence name
  def incidence_name
    INCIDENCE_NAMES[self.incidence]
  end

  private

  def either_goals_or_actions
    if !self.goals.empty? && !self.aktions.empty?
      self.errors.add_to_base t('goal.validations.goals_or_actions')
    end
  end

  def default_order
    if self.order_number.nil?
      previous = self.self_and_siblings.last(:order => 'order_number asc')
      self.order_number= previous.nil?? 1 : (previous.order_number + 1)
    end
  end

end
