class ConferenceCallsController < ApplicationController

  def new
  end

  def show
  end

  def create
    conference_call.save!
    redirect_to conference_call, notice: 'Conference call was successfully created.'
  end

  private

  def conference_call
    @conference_call ||= params[:id] ? ConferenceCall.find_by_code(params[:id]) : ConferenceCall.new(params[:conference_call])
  end
  helper_method :conference_call

end
