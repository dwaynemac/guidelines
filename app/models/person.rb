class Person < ActiveRecord::Base
  belongs_to :institution, :class_name => "Federation"
end
