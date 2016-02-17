require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe :validations do
    [:title, :date, :event_type].each do |attr|
      it "should validate the #{attr}" do
        event = Event.new()
        event.save
        expect(event.errors).to include(attr)
      end
    end

    it "should only include valid event types" do
      expect( build(:event).update_attributes(event_type: "cat") ).to eq( false )
    end
  end
end
