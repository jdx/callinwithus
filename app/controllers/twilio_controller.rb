class TwilioController < ApplicationController
  def call
    StatsMix.track('Call made', 1, { :state => params['FromState'] })
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to kawlin with us. Please enter your pin number.', :voice => 'woman'
      r.Gather 'numDigits' => 6, :action => twilio_call_with_code_url
    end

    return render :text => response.text
  end


  def call_with_code
    conference_call = ConferenceCall.find_by_code(params['Digits'])
    if conference_call
      ConferenceCaller.create!(
        :phone_number => params['Caller'],
        :country => params['CallerCountry'],
        :zip => params['CallerZip'],
        :city => params['CallerCity'],
        :conference_call => conference_call
      )
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Entering conference room.', :voice => 'woman'
        r.Dial :action => twilio_conference_ended_url do |d|
          r.Conference conference_call.code, 'waitUrl' => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.electronica'
        end
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Invalid pin. Please try again.', :voice => 'woman'
        r.Redirect twilio_call_url
      end
    end

    return render :text => response.text
  end

  def conference_ended
    conference_call = ConferenceCall.find_by_code(params['Digits'])
    conference_caller = conference_call.conference_callers.where(:phone_number => params['Caller'])
    conference_caller.duration = DateTime.to_i - conference_caller.created_at.to_i
    conference_caller.save!
    render :nothing => true
  end
end
