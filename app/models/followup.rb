class Followup < ActiveRecord::Base
  belongs_to :goal

  validates_presence_of :valid_on
  validates_presence_of :value

  validates_uniqueness_of :valid_on, :scope => [:goal_id]
end
