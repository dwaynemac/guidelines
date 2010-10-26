class OrderNr < ActiveRecord::Migration
  def self.up
    add_column(:goals, :order_number, :integer)
    add_column(:aktions, :order_number, :integer)
  end

  def self.down
    remove_column(:goals,:order_number)
    remove_column(:aktions,:order_number)
  end
end
