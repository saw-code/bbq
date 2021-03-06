class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :body,
            presence: true

  validates :user_name,
            presence: true,
            unless: -> { user.present? }

  def user_name
    user&.name || super
  end
end
