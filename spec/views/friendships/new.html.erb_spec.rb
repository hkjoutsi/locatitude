require 'rails_helper'

RSpec.describe "friendships/new", type: :view do
  before(:each) do
    assign(:friendship, Friendship.new(
      :requestor_id => 1,
      :requestee_id => 1
    ))
  end

  it "renders new friendship form" do
    render

    assert_select "form[action=?][method=?]", friendships_path, "post" do

      assert_select "input#friendship_requestor_id[name=?]", "friendship[requestor_id]"

      assert_select "input#friendship_requestee_id[name=?]", "friendship[requestee_id]"
    end
  end
end
