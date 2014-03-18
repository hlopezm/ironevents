class EventsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @events = Event.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @event = Event.friendly.find(params[:id])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(create_params)

    authorize @event

    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.friendly.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.friendly.find(params[:id])
    authorize @event

    if @event.update update_params
      redirect_to @event, notice: "#{@event.name} updated"
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.friendly.find(params[:id])

    authorize @event

    @event.destroy
    redirect_to events_path, notice: "#{@event.name} was removed"
  end

  def today
    @events = Event.for_today
    render 'index'
  end

  def next_week
    @events = Event.next_week
    render 'index'
  end

  def mine
    if current_user
      @events = current_user.events
      render 'index'
    else
      redirect_to events_path
    end
  end

  private

  def create_params
    params.require(:event).permit(:name, :description, :start_at, :end_at)
  end

  def update_params
    params.require(:event).permit(:name, :description, :start_at, :end_at)
  end
end
