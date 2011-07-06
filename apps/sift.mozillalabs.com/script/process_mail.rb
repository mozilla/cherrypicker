#!/usr/bin/ruby

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'mail'

require 'pp'

Bacn.transaction do
  bacon = Bacn.parse(ARGF.read)
  bacon.save! if bacon
end
