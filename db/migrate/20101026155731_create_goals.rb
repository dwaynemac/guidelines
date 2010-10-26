class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.integer :goal_id
      t.string :objective
      t.integer :value
      t.string :control_item
      t.integer :responsable_id
      t.date :due_on

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end
