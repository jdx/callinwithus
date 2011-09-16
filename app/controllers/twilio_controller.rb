class TwilioController < ApplicationController
  def call
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'hello there', :voice => 'woman'
    end

    render :text => response.text
  end
end
