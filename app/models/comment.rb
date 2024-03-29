class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  attr_accessible :user, :comment
end
