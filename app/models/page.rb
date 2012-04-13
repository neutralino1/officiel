class Page < ActiveRecord::Base

  has_many(:viewers, 
           :through => :permissions, 
           :source => :entity,
           :source_type => 'User',
           :class_name => 'User', 
           :conditions => ['permissions.rights = ?', 'read'])

  has_many(:editors, 
           :through => :permissions,
           :source => :entity,
           :source_type => 'User',
           :class_name => 'User', 
           :conditions => ['permissions.rights = ?', 'write'])

  has_many(:editor_teams,
           :through => :permissions,
           :source => :entity,
           :source_type => 'Team',
           :class_name => 'Team',
           :conditions => ['permissions.rights = ?', 'write'])

  has_many(:subscribers, 
           :through => :permissions,
           :source => :entity,
           :source_type => 'User',
           :class_name => 'User')

  has_many :permissions, :dependent => :destroy

  has_many :writes, :class_name => 'Permission', :conditions => ['permissions.rights = ?', 'write']
  has_many :reads, :class_name => 'Permission', :conditions => ['permissions.rights = ?', 'read']

  belongs_to :owner, :class_name => 'User', :foreign_key => :owner_id

  has_many :actions

  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :versions, :dependent => :destroy
  accepts_nested_attributes_for :versions

  def latest_version
    versions.find(:first, :order => 'created_at DESC')
  end

  def versions_grouped_by_version
    versions.group_by(&:version)
  end

  def non_editors
    User.all - editors - [owner]
  end

  def non_editor_teams
    Team.all - editor_teams
  end

  def non_subscribers
    User.all - subscribers - [owner]
  end

  def last_action
    actions.find(:first, :order => 'created_at DESC')
  end  

  def title
    latest_version.title
  end

end

