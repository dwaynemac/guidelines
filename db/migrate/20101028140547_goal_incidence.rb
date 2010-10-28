class GoalIncidence < ActiveRecord::Migration
  def self.up
    add_column(:goals, :incidence, :integer)
  end

  def self.down
    remove_column(:goals,:incidence)
  end
end
