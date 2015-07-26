require 'spec_helper'
require 'rails_helper'


feature "goal creation" do
  let(:user) { create(:user) }
  before(:each) do
    visit new_session_url
    login(user)
  end

  it "has correct page content" do
    visit new_user_goal_url(user.id)
    expect(page).to have_content("Create a Goal")
    expect(page).to have_content("Public")
    expect(page).to have_content("Private")
    expect(page).to have_content("Your Goal")
  end

  let(:goal) { build(:goal) }
  it "allows creation of a new goal" do
    visit new_user_goal_url(user.id)
    make_user_goal(goal)
    expect(page).to have_content(goal.body)
  end

  let(:bad_goal) { build(:goal, body: "" ) }
  it "doesn't allow blank goals" do
    expect(build(:goal, body: "" )).not_to be_valid
  end

  let(:private_goal) { build(:private_goal) }
  let(:user2) { create(:user2) }
  it "private goals are visible to other users" do
      visit new_user_goal_url(user.id)
      make_user_goal(private_goal)
      expect(page).to have_content(private_goal.body)
      logout
      login(user2)
      visit user_url(user)
      expect(page).not_to have_content(private_goal.body)
  end

end
