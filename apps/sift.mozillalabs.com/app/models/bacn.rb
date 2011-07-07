class Bacn < ActiveRecord::Base

  belongs_to :user
  
  has_many :mime_parts, :dependent => :destroy
  has_many :headers, :dependent => :destroy
  
  validates_presence_of :user_id


  def self.parse_source_from_address(address)
    address.to_s =~ /\@([^\@\>]+)/

    return $1.split(/\./).reverse.join(".")
  end

  def self.parse(raw)
    mail = Mail.new(raw)

    if user = User.find_by_email_or_named_address(mail['to'].to_s)
      bacn = Bacn.new({:user => user, :source => self.parse_source_from_address(mail['from'])})
    
      mail.header.fields.each do |field|
        bacn.headers << Header.new({:name => field.name, :value => field.value})
      end
    
      mail.parts.each do |part|
        mime_part = MimePart.new_from_mail_part(part)
        bacn.mime_parts << mime_part if mime_part
      end
      return bacn
    else
      print "to: " + mail['to'].to_s + " could not be found in the database"
      return nil
    end
  end
end
