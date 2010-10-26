class CreateInstitutions < ActiveRecord::Migration
  def self.up
    create_table :institutions do |t|
      t.integer :padma_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :institutions
  end
end
