class ConferenceCall < ActiveRecord::Base
  before_create :create_code

  def to_param
    self.code
  end

  private

  def create_code
    self.code = '9823798u'
  end
end
