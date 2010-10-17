class RenamePasswordToUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :encrypted_password, :crypted_password 
  end

  def self.down
    rename_column :users, :crypted_password, :encrypted_password 
  end
end
