class Member < ActiveRecord::Base

  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable

  # attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  has_one :contact

  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => ["video/mp4", "image/jpg", "image/jpeg", "image/gif", "image/png"]

  acts_as_voter
  acts_as_commontator
end