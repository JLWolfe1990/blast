class CreateAlertRequests < ActiveRecord::Migration
  def change
    create_table :alert_requests do |t|
      t.integer :offset_in_seconds
      t.belongs_to :event, index: true, foreign_key: true
      t.date :offset_date
      t.timestamps
    end
  end
end
