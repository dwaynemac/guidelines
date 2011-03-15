class Progress < ActiveRecord::Migration
  def self.up
    add_column :goals, :progress, :integer, :default => 0
    add_column :aktions, :progress, :integer, :default => 0

    add_column :goals, :status, :string, :default => "waiting"
    add_column :aktions, :status, :string, :default => "waiting"
  end

  def self.down
    remove_column :goals, :progress
    remove_column :aktions, :progress

    remove_column :goals, :status
    remove_column :aktions, :status
  end
end
