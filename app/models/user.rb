class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  has_many :trips
  has_many :comments
  validates :image, presence: true


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
