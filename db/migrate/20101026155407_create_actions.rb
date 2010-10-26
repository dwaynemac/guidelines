class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :aktions do |t|
      t.integer :goal_id
      t.string :what
      t.string :how
      t.string :why
      t.string :where
      t.integer :who_id
      t.date :begins_on
      t.date :ends_on

      t.timestamps
    end
  end

  def self.down
    drop_table :aktions
  end
end
