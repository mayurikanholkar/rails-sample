module SessionsController
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Member.create!(
        email: "mayuri@gmail.com", password: "123456789"
      )
      sign_in @user
    end
  end
end