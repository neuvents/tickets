class EventsController < ApplicationController
  def index
    render json: Event.all.includes(:ticket_types), serializer: EventSerializer[]
  end

  def show
    render json: find_event, serializer: EventSerializer
  end

  private

  def find_event
    Event.includes(:ticket_types).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    raise NotFoundError.new(e.message)
  end
end
