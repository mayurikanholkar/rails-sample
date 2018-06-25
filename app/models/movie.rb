class Movie < ApplicationRecord
  acts_as_votable
  has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]
  acts_as_commontable
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def cover_image_physical
    return nil if self.photo_file_name.blank?
    "#{self.photo.path}"
  end
end
