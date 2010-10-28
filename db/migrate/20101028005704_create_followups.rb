class CreateFollowups < ActiveRecord::Migration
  def self.up
    create_table :followups do |t|
      t.integer :value
      t.date :valid_on
      t.integer :goal_id

      t.timestamps
    end
  end

  def self.down
    drop_table :followups
  end
end
