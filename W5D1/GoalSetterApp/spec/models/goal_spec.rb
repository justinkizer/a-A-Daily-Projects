# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  content    :string
#  user_id    :integer
#  private    :boolean          default("f")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) do
    FactoryGirl.build(:goal,
      user_id: 2,
      title: "RSpec",
      content: "mastodon", private: true)
    end

  let(:user1) do
    FactoryGirl.build(:user,
      username: "Indy",
      password: "CrashandBurn")
    end

  let(:user2) do
    FactoryGirl.build(:user,
      username: "Snakes",
      password: "Eggsaregoodtosnakes")
    end

  feature "goals can be public or private" do
    before(:each) do
      User.create(username: "Indy", password: "CrashandBurn")
      Goal.create(user_id: 1, title: "RSpec", content: "mastodon", private: true, completed?: false)
      Goal.create(user_id: 1, title: "Capy", content: "cheescake", private: true, completed?: true)
    end

    scenario "goals index page shows no private goals" do
      visit goals_url
      expect(page).to_not have_content "RSpec"
    end

    scenario "public and private goals include on user's page" do
      visit new_session_url
      fill_in 'Username', with: "Indy"
      fill_in 'Password', with: "CrashandBurn"
      click_on 'Sign In'
      expect(page).to have_content "RSpec"
    end

  scenario "goals show as false when not complete" do
    visit new_session_url
    fill_in 'Username', with: "Indy"
    fill_in 'Password', with: "CrashandBurn"
    click_on 'Sign In'
    expect(page).to have_content "RSpec Complete?: False"
  end

  scenario "goals show as true when complete" do
    visit new_session_url
    fill_in 'Username', with: "Indy"
    fill_in 'Password', with: "CrashandBurn"
    click_on 'Sign In'
    expect(page).to have_content "Capy Complete?: True"
  end

end

  it { belong_to :user }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user) }







end
