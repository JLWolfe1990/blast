class EventsController < ActionController::Base
  def edit
    @event = Event.find(params.fetch(:id))
    if params[:adding_alert_requests]
      @event.alert_requests.build
    end
    render 'edit', layout:false
  end

  def update
    @event = Event.find(params.fetch(:id))

    saved = true
    ActiveRecord::Base.transaction do
      begin
        @event.update_attributes! object_params
      rescue Exception => e
        saved = false
        raise ActiveRecord::Rollback
      end
    end

    if saved
      render json: @event, root:false
    else
      render 'edit', layout:false
    end
  end

  def new
    @event = Event.new user: current_user, date: params[:date]
    if params[:adding_alert_requests]
      @event.alert_requests.build
    end
    render 'new', layout:false
  end

  def create
    created = true
    ActiveRecord::Base.transaction do
      begin
        @event = Event.new object_params
        @event.alert_requests.map(&:save)
      rescue ActiveRecord::RecordInvalid
        created = false
        raise ActiveRecord::Rollback
      end
    end
    if @event.save && created
      render json: @event, root:false
    else
      render 'new', layout:false
    end
  end

  private

  def object_params
    params.require(:event).permit(:user_id, :title, :date, :event_type, :alert_requests_attributes => [:id, :offset_in_seconds]);
  end
end