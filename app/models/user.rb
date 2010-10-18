# == Schema Information
# Schema version: 20101009164901
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	acts_as_authentic do |c|
    c.login_field = 'email'
  end

	attr_accessible :login, :email, :password, :password_confirmation, :birthday

	has_many :microposts, :dependent => :destroy
	has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
	has_many :following, :through => :relationships, :source => :followed
	has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
	
  def feed
	  Micropost.from_users_followed_by(self)
	end
	
	def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

	def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

	def activate!
    self.active = true
    save
  end
  
  def self.search(search)
	  if search
	    find(:all, :conditions => ['login LIKE ?', "%#{search}%"])
	  else
	    find(:all)
	  end
	end

 end
