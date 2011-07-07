class User < ActiveRecord::Base

  has_many :bacns
  
  validates_uniqueness_of :account
    
  ### There must be a better name for "named_address", basically
  ### I'm trying to parse Simon Wex <simon@simonwex.com> -> simon@simonwex.com
  def self.find_by_email_or_named_address(email_or_named_address)
    email = email_or_named_address
    if email_or_named_address =~ /\<([^\>]+)/
      email = $1
    end 
    return self.find_by_email(email)
  end
  
  def account
    if self[:account].nil?
      
      # Here we change the base of the user.id to the number of common nouns we have. 
      # We then use the common nouns as digits to create a non-numerical representation 
      # of their id as their account. The thought is that a collection of words is 
      # easier to remember, but harder to spam.
      common_nouns = I18n.t(:common_nouns)
      
      raise "Common nouns not set for current locale!" unless common_nouns.size > 0
      
      puts common_nouns
      base = common_nouns.size
      num = self.id
      words = []
      while num > 0
        words << common_nouns[num % base]
        num /= base
      end
      self.account = words.join('-')
    end
    self[:account]
  end
  
  def session_hash
    {
      :id => self.id,
      :account => self.account,
      :email => self.email
    }
  end
  
end
