require_relative 'application_serializer.rb'

class EventSerializer < ApplicationSerializer
  attributes :event_type, :title, :date, :created_at, :updated_at, :edit_path

  def edit_path
    edit_event_path(id: object_id)
  end
end