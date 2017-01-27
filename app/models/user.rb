require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true
  property :password, BCryptHash
  attr_accessor :password_conf

  validates_confirmation_of :password, confirm: :password_conf

end
