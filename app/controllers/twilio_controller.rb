class TwilioController < ApplicationController
  def call
    if params[:digits]
      response = Twilio::TwiML::Response.new do |r|
        r.Say "You entered #{ params[:digits] }"
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Welcome to Call In With Us, please enter your pin number.', :voice => 'woman'
        r.Gather :num_digits => 6
      end
    end

    render :text => response.text
  end
end
