require 'rails_helper'

RSpec.describe User, type: :model do
it "has the username set correctly" do
    #user = User.new username:"Pekka"
	user = FactoryGirl.create(:user)
    #user.username.should == "Pekka"
    expect(user.username).to eq("Pekka")
  end

  #it "is not saved without a password" do
  #  user = User.create username:"Pekka"
  #
  #    expect(user.valid?).to be(false)
  #    expect(User.count).to eq(0)
  #  end
end
