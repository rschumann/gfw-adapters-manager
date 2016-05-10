class AdminUser < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id, touch: true

  delegate :firstname, :lastname, :name, :email, :institution, :active, :username, to: :user
  validates :user_id, presence: true, uniqueness: true
end