# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

describe User do
  subject(:user) do
    FactoryGirl.build(:user,
      username: "Justin",
      password: "mastodon")
    end

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  it "should set a password_digest from given password" do
    expect(user.password_digest).to_not be_nil
  end

  it "should set a session token" do
    expect(user.session_token).to_not be_nil
  end

  describe "#is_password?" do
    it "should verify password_digest against given password" do
      expect(user.is_password?("mastodon")).to be true
    end
  end

  describe "#find_by_credentials" do
    it "should find a user by credentials" do
      user.save!
      expect(User.find_by_credentials("Justin", "mastodon")).to eq(user)
    end
  end

end
end
