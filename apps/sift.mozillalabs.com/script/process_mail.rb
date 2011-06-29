#!/usr/bin/ruby

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'mail'

require 'pp'

Bacn.transaction do 
  Bacn.parse(ARGF.read).save!
end
