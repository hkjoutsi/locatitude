require 'rails_helper'

RSpec.describe "friendships/edit", type: :view do
  before(:each) do
    @friendship = assign(:friendship, Friendship.create!(
      :requestor_id => 1,
      :requestee_id => 1
    ))
  end

  it "renders the edit friendship form" do
    render

    assert_select "form[action=?][method=?]", friendship_path(@friendship), "post" do

      assert_select "input#friendship_requestor_id[name=?]", "friendship[requestor_id]"

      assert_select "input#friendship_requestee_id[name=?]", "friendship[requestee_id]"
    end
  end
end
