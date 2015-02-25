class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :uniqueness => true

  def fullname
    self.first_name + ' ' + self.last_name  
  end

end
