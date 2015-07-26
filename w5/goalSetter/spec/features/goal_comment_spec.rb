require 'spec_helper'
require 'rails_helper'

feature "Creation of goal comment"
  let(:user) { create(:user) }
  before(:each) do
    visit new_session_url
    login(user)
  end

  let(:user2) { create(:user2) }
  it "is on users show page under goal" do
    visit user_url(user2)
    expect(page).to have_content("Post Comment for this Goal")
  end

  let(:goal_comment) { build(:goal_comment) }
  it "post on user page under associated link" do
    visit user_url(user2)
    make_goal_comment(goal_comment)
    expect(page).to have_content(goal_comment.body)
  end
end
