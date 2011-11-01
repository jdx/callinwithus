class ConferenceCallsController < ApplicationController

  def new
    @conference_call = ConferenceCall.create!
    redirect_to "/#{ @conference_call.code_for_display }"
  end

  def show
    @conference_call = ConferenceCall.find_by_code! params[:code].sub('-','')
  end
end
