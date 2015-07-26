require 'spec_helper'
require 'rails_helper'

feature "Creation of comment"
  let(:user) { create(:user) }
  before(:each) do
    visit new_session_url
    login(user)
  end

  let(:user2) { create(:user2) }
  it "is on users show page" do
    visit user_url(user2)
    expect(page).to have_content("Post Comment")
  end

  let(:comment) { build(:comment) }
  it "post on user page" do
    visit user_url(user2)
    make_comment(comment)
    expect(page).to have_content(comment.body)
  end


end
