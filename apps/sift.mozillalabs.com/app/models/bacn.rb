class Bacn < ActiveRecord::Base

  belongs_to :user
  
  has_many :mime_parts
  has_many :headers
  

  def self.parse(raw)
    mail = Mail.new(raw)
    require 'pp'
    pp mail.header.fields
    Bacn.new
  end
end
