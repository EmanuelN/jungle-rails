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

  def self.authenticate_with_credentials(email_input, password_input)
    user = User.find_by(email: email_input)
    if !user.nil? && user.authenticate(password_input)
      user
    else
      nil
    end
  end

end
