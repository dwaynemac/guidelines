class Aktion < ActiveRecord::Base
  belongs_to :goal
  belongs_to :who, :class_name => "Person"

  validates_presence_of :goal
end
