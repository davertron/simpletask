class User
  include MongoMapper::Document

  authenticates_with_sorcery!
  attr_protected :crypted_password, :salt

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_many :tasks

  key :username, String
  key :email, String
  key :crypted_password, String
  key :salt, String
end
