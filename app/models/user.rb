class User < ApplicationRecord
  has_secure_password
  enum role: { user: 0, admin: 1 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy
  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end
