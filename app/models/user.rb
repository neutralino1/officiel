class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :omniauthable

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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name
end
