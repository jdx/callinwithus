class ConferenceCallsController < ApplicationController

  def new
    @old_thing = ConferenceCall.order('created_at').limit(1).first
    @old_thing.destroy if @old_thing
    @conference_call = ConferenceCall.create!
    redirect_to "/#{ @conference_call.code_for_display }"
  end

  def show
    @conference_call = ConferenceCall.find_by_code! params[:code].sub('-','')
  end
end
