class ConferenceCall < ActiveRecord::Base
  before_create :create_code

  def to_param
    self.code
  end

  private

  def create_code
    chars = '0123456789'
    self.code = ''
    6.times { |i| self.code << chars[rand(chars.length)] }
  end
end
