class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :omniauthable

  has_and_belongs_to_many :teams
  has_many :permissions, :as => :entity

  def full_name
    name = ''
    name += first_name if first_name
    name += ' ' unless name.empty?
    name += last_name if last_name
    name.empty? ? 'Unknown' : name
  end

  alias :name :full_name

  def typed_id
    'user_' + id.to_s
  end

  def other_teams
    Team.all - teams
  end

  def can_edit_user?(user)
    root? || user == self
  end

  def can_edit_team?(team)
    root?
  end

  def can_view_page?(page)
    page.owner == self || page.editors.include?(self) || page.viewers.include?(self)
  end

  def can_edit_page?(page)
    page.owner == self || page.editors.include?(self) || ((teams & page.editor_teams).count > 0)
  end

  def can_create_team?
    root?
  end

  def owns?(page)
    page.owner == self
  end

  def root?
    status == 'root'
  end

  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data["email"]).first
      user
    elsif data["email"] =~ /official.fm$/
      User.create!(:email => data["email"], 
                   :encrypted_password => Devise.friendly_token[0,20], 
                   :first_name => data["email"].split('@')[0].capitalize)
    else
      nil
    end
  end
  
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :position, :skype, :twitter, :facebook
end
