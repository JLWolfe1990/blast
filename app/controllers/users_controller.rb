class UsersController < ApplicationController
  def dashboard
    @events = current_user.events
  end
end
