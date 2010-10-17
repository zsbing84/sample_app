class RenameSaltToUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :salt, :password_salt 
  end

  def self.down
    rename_column :users, :password_salt, :salt 
  end
end
