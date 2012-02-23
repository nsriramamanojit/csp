class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
  end
  #validations
  validates :name, :presence => true, :length => {:maximum => 100}
  validates :password, :presence => true, :length => {:maximum => 100}
  validates :login, :presence => true, :length => {:maximum => 10},:uniqueness => true
  validates :mobile_number, :length => {:maximum => 6}

end
