class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :page

  attr_accessible :user, :action, :page

  def action_past
    return 'viewed' if action == 'view'
    return 'updated' if action == 'update'
    return 'created' if action == 'create'
  end

  def self.create_action(p)#:page => page, :user => user, :action => action)
    last = p[:page].last_action
    if last and last.user == p[:user] and last.action == p[:action]
      last.update_attribute(:updated_at, Time.now)
    else
      unless last and last.user == p[:user] and last.action != 'view' and last.page == p[:page] and p[:action] == 'view'
        self.create(p)
      end
    end
  end


end
