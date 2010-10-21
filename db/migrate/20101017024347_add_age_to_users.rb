class AddAgeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :age, :integer
  end

  def self.down
    remove_column :users, :age
  end
end
