class ConferenceCallsController < ApplicationController

  def new
    StatsMix.track('Page visit', 1)
    @conference_call = ConferenceCall.create!
  end
end
