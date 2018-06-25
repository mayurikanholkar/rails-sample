class HomeController < ApplicationController
  # respond_to :html, :json
  require "twilio-ruby"
  @@pin = ""
  @@piny = ""
  resp_arr = []

  def listing_user
    @members = Member.all
    
  end

  def edit
    @member = Member.find_by(id: params[:id])   
    @contact = @member.contact 
  end

  def update    
    @member = Member.find_by(id: params[:id])   
    @contact = @member.contact
    if params[:member][:password].present?      
      @member.update(member_params)
    else
      @member.update(member_without_pass_params)
    end
    @contact.update(contact_params)
    redirect_to root_path
  end

  def show
    @member = Member.find_by_id(params[:id])   
    @contact = @member.contact 
  end


  def send_sms
    @@pin = rand(0000..9999).to_s.rjust(4, "0")
    ENV['TWILIO_ACCOUNT_SID'] = "AC853de4b89d2f2dea4efa5a00b0910712" #Client's SID number
    # "AC48df98e647aea951b4c71477bbc26863"
    ENV['TWILIO_AUTH_TOKEN'] = "255d7ca879eda65a869ad2067e820364" #Client's Auth token number
    # "5819a96aed8298f4201ad10f552d67b5"
    ENV['TWILIO_NUMBER'] = "+19286156559" #Client's Twilio number
    # "+17153180289"
    # Twilio::REST::RequestError
    begin
      client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      response = client.messages.create(from: ENV['TWILIO_NUMBER'], to:   params[:phone], body: "\nyour otp for mayuri's dummy app is \n #{@@pin}")
      render json: {:pin => @@pin}, status: :ok 
    rescue Twilio::REST::RequestError => e
      render json: {:errmsg => e.message}, status: :ok 
    end
  end
 

  def otp_verify
    @member = Member.find_by(params[:user_id])
    if @@pin == params[:entered_otp_pin]
      @member.otp = @@pin
      @member.save
      render json: {:otp_verification_status => true}, status: :ok 
    else
      render json: {:otp_verification_status => false}
    end
  end


  private
  def member_params
    params.require(:member).permit(:image, :picture, :username, :email, :password, :password_confirmation)
  end 
  
  def member_without_pass_params
    params.require(:member).permit(:image, :picture, :username, :email)
  end 

  def contact_params
    params.require(:contact).permit(:mobile, :address)
  end  

end
