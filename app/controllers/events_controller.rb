class EventsController < ApplicationController
  def index
    render json: Event.all, serializer: EventSerializer[]
  end

  def show
    event = Event.includes(:ticket_types).find(params[:id])

    render json: event, serializer: CompleteEventSerializer
  end
end
