class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  attr_accessible :type
end