class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.belongs_to :alert_request, index: true, foreign_key: true
      t.text :body
      t.string :subject
      t.timestamps
    end
  end
end
