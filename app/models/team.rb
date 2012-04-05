class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  def typed_id
    'team_' + id.to_s
  end
end
