class AddFieldsToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :recipient_emails, :text
    add_column :alerts, :sent_at, :datetime
    add_column :alerts, :failed_at, :datetime
  end
end
