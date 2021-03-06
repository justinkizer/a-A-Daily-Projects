# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base

  validates :title, :author_id, presence: true

  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :subs, through: :post_subs, source: :sub

end
