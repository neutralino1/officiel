class Page < ActiveRecord::Base

#  has_one(:owner, 
#          :through => :permissions, 
#          :source => :user, 
#          :class_name => 'User', 
#          :conditions => ['permissions.owner = ?', true])

  has_many(:viewers, 
           :through => :permissions, 
           :source => :user,
           :class_name => 'User', 
           :conditions => ['permissions.type = ?', 'read'])

  has_many(:editors, 
           :through => :permissions,
           :source => :user,
           :class_name => 'User', 
           :conditions => ['permissions.type = ?', 'write'])
  has_many :permissions, :dependent => :destroy

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id
  
end
