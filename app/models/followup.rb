class Followup < ActiveRecord::Base
  belongs_to :goal

  validates_presence_of :valid_on
  validates_presence_of :value
end
