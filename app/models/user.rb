class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, uniqueness: true, length: {in: 2..20}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :authentication_keys => [:name]

  validates :email, presence: true
  validates :introduction, length: {maximum: 50}

  attachment :profile_image

  has_many :books, dependent: :destroy

  def email_required?
  	false
  end
  def email_changed?
  	false
  end
end
