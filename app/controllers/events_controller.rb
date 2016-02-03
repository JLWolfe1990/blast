class EventsController < ActionController::Base
  def new
    @event = Event.new user: current_user, date: params[:date]
    render partial: 'form', layout:false
  end

  def create
    @event = Event.new object_params
    if @event.save
      render json: @event
    else
      render partial: 'form', layout:false
    end
  end

  private

  def object_params
    params.require(:event).permit(:user_id, :title, :date, :event_type);
  end
end