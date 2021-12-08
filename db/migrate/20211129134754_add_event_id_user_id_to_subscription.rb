class AddEventIdUserIdToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :event, index: true, foreign_key: true
    add_reference :subscriptions, :user, index: true, foreign_key: true
  end
end
