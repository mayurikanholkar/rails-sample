require 'rails_helper'

RSpec.describe RegistrationController, type: :controller do 
  login_user

  before(:all) do 
    image_path1 = "#{Rails.root}/app/assets/images/img2.jpeg"
    image_file1 = File.new(image_path1)
    image_path2 = "#{Rails.root}/app/assets/images/v4.mp4"
    image_file2 = File.new(image_path2)
    @image = ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file1),:tempfile => image_file1,:type => MIME::Types.type_for(image_path1).first.content_type)
    @video = ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file2),:tempfile => image_file2,:type => MIME::Types.type_for(image_path2).first.content_type)
  end  
  
  describe "create #member" do
    it "shwoing member saving status" do    
      member = Member.new( 
        username: "mark",
        email: "mark5@gmail.com", 
        password: 123456, 
        password_confirmation: 123456, 
        image: @image,
        picture: @video
      )
      member.save
      contact = Contact.new(mobile: 1236547896, address: "mark address")
      contact.member_id = member.id
      contact.save
      expect(response.status).to eq 200
    end

    # it "creating member" do
    #   @request.env["devise.mapping"] = Devise.mappings[:member]
    #   params1 = {member: { 
    #     username: "mark",
    #     email: "mark5@gmail.com", 
    #     password: 123456, 
    #     password_confirmation: 123456, 
    #     image: @image,
    #     picture: @video
    #   } }
    #   params2 = {contact: {mobile: 1236547896, address: "mark address"}}
    #   post :create, params: params1, params: params2
    #   expect(response.status).to eq 200
    # end
  end
end