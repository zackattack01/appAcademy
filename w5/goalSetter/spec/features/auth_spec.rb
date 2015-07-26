require 'spec_helper'
require 'rails_helper'


feature "the signup process" do
  let(:user) { build(:user) }
  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content('Sign Up')
  end

  #let(:user) { build(:user) }
  feature "signing up a user" do
    let(:user) { build(:user) }
    it "shows username on the homepage after signup" do
      visit new_user_url
      expect(page).to have_content('Sign Up')
      signup(user)
      expect(page).to have_content(user.username)
    end
  end

end


feature "logging in" do
  let(:user) { create(:user) }
  it "shows username on the homepage after login" do
    visit new_session_url
    expect(page).to have_content("Sign In")
    login(user)
    expect(page).to have_content(user.username)
  end
end

feature "logging out" do
  let(:user) { create(:user) }
  it "begins with logged out state" do
    visit user_url(user)
    expect(page).to have_content('Sign In')
  end

  it "doesn't show username on the homepage after logout" do
    visit new_session_url
    login(user)
    click_button('Log Out')
    expect(page).not_to have_content(user.username)
  end
end
