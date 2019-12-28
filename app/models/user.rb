class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :cl_image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :comments
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
end
