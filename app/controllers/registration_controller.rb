class RegistrationController < Devise::RegistrationsController
  
  def new
    @member= Member.new
    @contact = Contact.new
  end

  def create
    debugger
    @member = Member.new(member_params)
    @contact = Contact.new(contact_params)
    @member.valid?

    if @member.errors.blank?
      @member.save
      @contact.member = @member
      @contact.save
      redirect_to dashboard_path
    else
      render :action => "new"
    end
  end

  private
  def member_params
    params.require(:member).permit(:image, :picture, :username, :email, :password, :password_confirmation)
  end  

  def contact_params
    params.require(:contact).permit(:mobile, :address)
  end     
  
end