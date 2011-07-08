class Permission < ActiveRecord::Base
  
  validates_uniqueness_of :source, :scope => :user_id
  
  validates_presence_of :source
  
  VALUES = [:ignore, :display, :forward]
  
  def init
    self.value = :display
  end
  
  def value
    self[:value].to_sym
  end
end
