class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  has_many :task_assignments, dependent: :destroy
  has_many :tasks, through: :task_assignments

  
  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end
   
  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end
  
  def reset_password!(password)
   self.reset_password_token = nil
   self.password = password
   save!
  end
  
  private
  
  def generate_token
   SecureRandom.hex(10)
  end
end
