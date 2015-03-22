require 'rails_helper'

describe "Users page" do
  it "should not have any before created" do
    visit users_path
    expect(page).to have_content 'Listing Users'
    expect(page).to_not have_content 'Pekka'
  end

  it "should have Pekka after user created" do
    FactoryGirl.create :user
    visit users_path
    expect(page).to have_content 'Listing Users'
    expect(page).to have_content 'Pekka'
  end
end