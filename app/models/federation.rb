class Federation < ActiveRecord::Base
  has_many :people, :foreign_key => :institution_id
  has_many :users, :foreign_key => :institution_id
  has_many :goals, :foreign_key => :institution_id
  has_many :aktions, :through => :goals
end
