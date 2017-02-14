class ContactShare < ActiveRecord::Base

  validates :contact_id, :user_id, presence: true
  validates :contact_id, uniqueness: { scope: :user_id }

  belongs_to :contact

  belongs_to :contact_recipient,
    class_name: :User,
    foreign_key: :user_id

  has_many :shared_users,
  through: :contact,
  source: :owner

end
