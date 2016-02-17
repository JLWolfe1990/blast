require 'rails_helper'

RSpec.describe EventSerializer, :type => :serializer do
  let :event_json do
    EventSerializer.new( create(:event), root: false ).as_json
  end

  describe :attributes do
    [:create_path, :edit_path, :update_path, :id, :title, :date, :event_type].each do |attr|
      it "should include the #{attr} attribute" do
        expect( event_json[attr] ).to_not be_blank
      end
    end
  end
end
