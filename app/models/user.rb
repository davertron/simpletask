class User
  include MongoMapper::Document

  authenticates_with_sorcery!
  attr_protected :crypted_password, :salt, :is_admin

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates_uniqueness_of :username

  has_many :tasks

  key :username, String
  key :email, String
  key :is_admin, Boolean, :default => false
  key :crypted_password, String
  key :salt, String
end
