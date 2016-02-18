require_relative 'application_serializer.rb'

class EventSerializer < ApplicationSerializer
  attributes :event_type, :title, :date, :created_at, :updated_at
  attributes :create_path, :edit_path, :update_path

  def create_path
    events_path()
  end

  def edit_path
    object.try(:persisted?) ? edit_event_path(object.id) : ""
  end

  def update_path
    object.try(:persisted?) ? event_path(object.id) : ""
  end
end