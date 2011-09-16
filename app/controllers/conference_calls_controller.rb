class ConferenceCallsController < ApplicationController

  def new
    @conference_call = ConferenceCall.create!
  end
end
