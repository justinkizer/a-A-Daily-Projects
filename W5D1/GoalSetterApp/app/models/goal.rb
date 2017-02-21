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

class Goal < ApplicationRecord

  validates :user, :content, presence: true

  belongs_to :user

end
