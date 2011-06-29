class MimePart < ActiveRecord::Base
  
  belongs_to :bacn
  
  SUPPORTED_CONTENT_TYPES = [/^text\/plain/, /^text\/html/]
  
  def self.valid_content_type?(content_type)
    SUPPORTED_CONTENT_TYPES.each do |test|
      if content_type =~ test
        return true
      end
    end
    
    return false
  end
  
  def valid_content_type?
    MimePart.valid_content_type?(self.content_type)
  end
  
  def self.new_from_mail_part(part)
    if MimePart.valid_content_type?(part.content_type)
      MimePart.new(:content_type => part.content_type, :body => Sanitize.clean(part.body.to_s, Sanitize::Config::RELAXED))
    else
      return false
    end
  end
end
