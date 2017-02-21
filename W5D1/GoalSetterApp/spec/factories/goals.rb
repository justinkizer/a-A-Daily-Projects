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

FactoryGirl.define do
  factory :goal do
    
  end
end
