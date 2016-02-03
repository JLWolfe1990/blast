class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_type
      t.date :date
      t.belongs_to :user
      t.string :title

      t.timestamps null: false
    end
  end
end
