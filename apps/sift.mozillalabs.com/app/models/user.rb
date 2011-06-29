class User < ActiveRecord::Base
  has_many :bacns
  
  ### There must be a better name for "named_address", basically
  ### I'm trying to parse Simon Wex <simon@simonwex.com> -> simon@simonwex.com
  def self.find_by_email_or_named_address(email_or_named_address)
    email = email_or_named_address
    if email_or_named_address =~ /\<([^\>]+)/
      email = $1
    end 
    return self.find_by_email(email)
  end
end
