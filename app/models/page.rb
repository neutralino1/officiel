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
           :conditions => ['permissions.rights = ?', 'read'])

  has_many(:editors, 
           :through => :permissions,
           :source => :user,
           :class_name => 'User', 
           :conditions => ['permissions.rights = ?', 'write'])

  has_many(:subscribers, 
           :through => :permissions,
           :source => :user,
           :class_name => 'User')

  has_many :permissions, :dependent => :destroy

  has_many :writes, :class_name => 'Permission', :conditions => ['permissions.rights = ?', 'write']
  has_many :reads, :class_name => 'Permission', :conditions => ['permissions.rights = ?', 'read']

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id

  def non_editors
    User.all - editors - [owner]
  end

  def non_subscribers
    User.all - subscribers - [owner]
  end
  
end
