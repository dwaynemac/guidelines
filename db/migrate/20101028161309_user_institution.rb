class UserInstitution < ActiveRecord::Migration
  def self.up
    add_column(:people, :institution_id, :integer)
  end

  def self.down
    remove_column(:people, :institution_id)
  end
end
