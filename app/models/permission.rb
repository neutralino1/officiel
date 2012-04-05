class Permission < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  belongs_to :page
  attr_accessible :rights, :entity, :page
 
  def user
    entity.is_a?(User) ? entity : nil
  end

  def team
    entity.is_a?(Team) ? entity : nil
  end
end
