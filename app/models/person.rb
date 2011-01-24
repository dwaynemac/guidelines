class Person < ActiveRecord::Base
  belongs_to :institution, :class_name => "Federation"

  validates_uniqueness_of :name
end
