class FinishGoal < ActiveRecord::Migration
  def self.up
    add_column :goals, :completed, :boolean
  end

  def self.down
    remove_column(:goals, :completed)
  end
end
