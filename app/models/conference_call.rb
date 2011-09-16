class ConferenceCall < ActiveRecord::Base
  before_create :create_code
  after_create :notify_statsmix

  has_many :conference_callers

  def to_param
    self.code
  end

  private

  def create_code
    chars = '0123456789'
    self.code = ''
    6.times { |i| self.code << chars[rand(chars.length)] }
  end

  def notify_statsmix
    StatsMix.track('Total conference calls', ConferenceCall.all.count)
  end
end
