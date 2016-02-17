require 'rails_helper'

RSpec.describe AlertRequest, :type => :model do
  describe :validations do
    it "should not be valid without an event" do
      alert_request = build(:alert_request, event: nil)
      alert_request.save

      expect(alert_request.errors).to include(:event)
    end

    it "should not be valid without an offset time" do
      alert_request = build(:alert_request, offset_in_seconds: nil)
      alert_request.save

      expect(alert_request.errors).to include(:offset_in_seconds)
    end
  end

  describe :after_saves do
    it "should update the offset_date attribute" do
      event = create(:event, date: Date.today)
      alert_request = create(:alert_request, event: event, offset_in_seconds: 1.day.seconds)

      expect(alert_request.reload.offset_date).to eq(Date.today - 1.day)

      event.update_attributes date: 2.days.ago

      expect(alert_request.reload.offset_date).to eq(Date.today - 3.days)
    end
  end
end
