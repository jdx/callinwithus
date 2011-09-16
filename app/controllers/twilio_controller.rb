class TwilioController < ApplicationController
  def call
    if params['Digits']
      response = Twilio::TwiML::Response.new do |r|
        r.Say "You entered #{ params['Digits'] }"
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Welcome to kawlin withus, please enter your pin number.', :voice => 'woman'
        r.Gather 'numDigits' => 6
      end
    end

    render :text => response.text
  end
end
