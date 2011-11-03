class ConferenceCall < ActiveRecord::Base
  before_create :create_code

  has_many :conference_callers

  def to_param
    self.code
  end

  def code_for_display
    split_code = self.code.match(/(\d{3})(\d*)/)
    return "#{ split_code[1] }-#{ split_code[2] }#"
  end

  private

  def create_code(digits=5)
    chars = '0123456789'
    self.code = ''
    digits.times { |i| self.code << chars[rand(chars.length)] }
    create_code(digits = digits + 1) if ConferenceCall.find_by_code(self.code)
  end
end
