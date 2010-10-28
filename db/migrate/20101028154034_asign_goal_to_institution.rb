class AsignGoalToInstitution < ActiveRecord::Migration
  def self.up
    add_column(:goals, :institution_id, :integer)
  end

  def self.down
    remove_column(:goals, :institution_id)
  end
end
