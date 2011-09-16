class ConferenceCaller < ActiveRecord::Base
  after_create :notify_statsmix

  belongs_to :conference_call

  private

  def notify_statsmix
    StatsMix.track('Total conference callers', ConferenceCall.all.count)
  end
end
