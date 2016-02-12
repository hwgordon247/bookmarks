require 'bcrypt'

class User
include DataMapper::Resource


  def self.authenticate(user_name, password)
    user = first(user_name: user_name)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end


  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, as: :email_address


    property :id, Serial
    property :user_name, String
    property :email, String, required: true, unique: true
    property :password_digest, Text

    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(password)
    end


end
