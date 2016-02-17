require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  render_views

  let :user do
    create(:user)
  end

  let :event_json do
    create(:event, user: user).as_json
  end

  context("with a signed in user") do
    before(:each) do
      sign_in user
    end
    context("#update") do
      def do_put_update(json = event_json)
        put :update, id: json["id"], event: json
      end

      context("on a successful request") do
        it "should successfully update the title" do
          title = "a wonderful title"
          do_put_update event_json.merge(title: title)

          expect(response_body["title"]).to eq(title)
        end

        it "should return an object without a root" do
          do_put_update

          expect(JSON.parse(response.body)["event"]).to be_blank
        end
      end

      context("on an unsuccessful request") do
        it "should return HTML" do
          do_put_update event_json.merge(date: nil)

          expect(response.body).to match(/form/)
        end
      end
    end

    context("#create") do
      #override top level method
      let :event_json do
        build(:event, user: user).as_json
      end

      def do_post_create(json = event_json)
        post :create, event: json
      end


      context("on a successful request") do
        it "should successfully create the title" do
          title = "a wonderful title"
          do_post_create event_json.merge(title: title)

          expect(response_body["title"]).to eq(title)
        end

        it "should return an object without a root" do
          do_post_create

          expect(JSON.parse(response.body)["event"]).to be_blank
        end
      end

      context("on an unsuccessful request") do
        it "should return HTML" do
          do_post_create event_json.merge(date: nil)

          expect(response.body).to match(/form/)
        end
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end

end
