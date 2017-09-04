class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews



  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence:true

  validates :email, confirmation: true
  validates :email, presence:true
  validates :email, uniqueness: { case_sensitive: false }
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
