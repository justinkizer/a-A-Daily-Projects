require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username', with: "Indiana Jones"
      fill_in 'Password', with: "Flyover"
      click_on "Sign Up"
      expect(page).to have_content "Indiana Jones"
    end

  end

end

feature "logging in" do
  before(:each) do
    User.create(username: "Indiana Jones", password: "Flyover")
  end

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'Username', with: "Indiana Jones"
    fill_in 'Password', with: "Flyover"
    click_on "Sign In"
    expect(page).to have_content "Indiana Jones"
  end

end

feature "logging out" do
  before(:each) do
    User.create(username: "Indiana Jones", password: "Flyover")
  end
  scenario "begins with a logged out state" do
    visit root_url
    expect(page).to have_content "Sign In"
    expect(current_path).to eq("/")
  end


  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in 'Username', with: "Indiana Jones"
    fill_in 'Password', with: "Flyover"
    click_on "Sign In"
    click_on "Sign Out"

    expect(page).to_not have_content "Indiana Jones"
  end

end
