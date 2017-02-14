class Contact < ActiveRecord::Base

  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: {scope: :user_id}

  belongs_to :owner,
    class_name: :User,
    foreign_key: :user_id

  has_many :contact_shares

end
