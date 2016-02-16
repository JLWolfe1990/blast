class EventsController < ActionController::Base
  def edit
    @event = Event.find(params.fetch(:id))
    render partial: 'form', layout:false
  end

  def update
    @event = Event.find(params.fetch(:id))
    if @event.update_attributes(object_params)
      render json: @event, root:false
    else
      render partial: 'form', layout:false
    end
  end

  def new
    @event = Event.new user: current_user, date: params[:date]
    render partial: 'form', layout:false
  end

  def create
    @event = Event.new object_params
    if @event.save
      render json: @event, root:false
    else
      render partial: 'form', layout:false
    end
  end

  private

  def object_params
    params.require(:event).permit(:user_id, :title, :date, :event_type);
  end
end