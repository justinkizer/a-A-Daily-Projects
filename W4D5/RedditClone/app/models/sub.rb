# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base

  validates :title, :description, :moderator_id, presence: true



end

# A title attribute (required)
# A url attribute (optional)
# A content attribute for content text (optional)
# A sub association to the Sub the Post is submitted to (required)
# An author association.
# Again, write all the standard PostsController actions, excepting index (the subs#show can list posts).

# Write posts#edit and posts#update controller actions (and routes) that only the Post author can use.
