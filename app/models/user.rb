class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true

  validates :password, presence: true, on: :create, length: {minimum: 3}

  sluggable_column :username

  def admin?
    self.role.to_s == 'admin'
  end

  def moderator?
    self.role.to_s == "moderator"
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6-digit number
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'AC4fa5948d61c9e5aca6562c691d512252' 
    auth_token = 'ea88b63d6efcf92b8ca71600620d5864' 
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
    msg = "Hi, here is your one-time pin.  Please use this pin to log in to your account. Pin: #{self.pin}"
    client.account.messages.create({
      :from => '+18046217303',
      :to   => self.phone,
      :body => msg   
    })
  end
  
end