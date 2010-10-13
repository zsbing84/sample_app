# == Schema Information
# Schema version: 20101012145409
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
	attr_accessible :content
	validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
	belongs_to :user

  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  private

    def self.followed_by(user)
      followed_ids = user.following.map(&:id).join(", ")
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end

end
