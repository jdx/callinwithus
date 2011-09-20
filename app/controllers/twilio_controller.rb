class TwilioController < ApplicationController
  def call
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Please enter your pin number.', :voice => 'woman', :language => localized_language(params['CallerCountry'])
      r.Gather :action => twilio_call_with_code_url
    end

    return render :text => response.text
  end


  def call_with_code
    conference_call = ConferenceCall.find_by_code(params['Digits'])
    if conference_call
      ConferenceCaller.create!(
        :phone_number => params['Caller'],
        :country => params['CallerCountry'],
        :state => params['CallerState'],
        :zip => params['CallerZip'],
        :city => params['CallerCity'],
        :conference_call => conference_call
      )
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Entering conference room.', :voice => 'woman', :language => localized_language(params['CallerCountry'])
        r.Dial :action => twilio_conference_ended_url do |d|
          r.Conference conference_call.code, 'waitUrl' => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.electronica'
        end
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Invalid pin. Please try again.', :voice => 'woman', :language => localized_language(params['CallerCountry'])
        r.Redirect twilio_call_url
      end
    end

    return render :text => response.text
  end

  def conference_ended
    conference_caller = ConferenceCaller.where(:phone_number => params['Caller']).order('created_at').last
    conference_caller.duration = DateTime.now.to_i - conference_caller.created_at.to_i
    conference_caller.save!

    conference_call = conference_caller.conference_call
    conference_call.duration = conference_caller.duration
    conference_call.save!

    render :nothing => true
  end

  private

  def localized_language(country)
    return country == 'UK' ? 'en-gb' : 'en'
  end
end
