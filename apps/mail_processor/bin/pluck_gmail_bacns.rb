#!/usr/bin/ruby

require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require 'yaml'

config_file = "#{APP_ROOT}/config/mail_fetcher.yml"

if !File.exist?(config_file)
  puts "Missing configuration file #{config_file}.\n Copy the sample found in the same directory."
end

config = YAML.load(IO.read(config_file))

require 'net/imap'
gem 'mail'
require 'highline/import'

password = ask("Please enter password for account #{config['username']}") {|q| q.echo = '*'}
puts
puts "Looking on server #{config['server']} for unread emails in the #{config['folder']} folder."

imap = Net::IMAP.new(config['server'], config['port'], config['ssl'])
imap.login(config['username'], password)
imap.select(config['folder'])


imap.search(['NOT', 'Seen']).each do |message_id|
  mail = imap.fetch(message_id, 'RFC822')[0].attr['RFC822'] #.split("\r\n").each # do |line|
  path = "#{APP_ROOT}/fixtures/#{message_id}.eml"
  puts "Writing file: #{path}"
  File.open(path, 'w') do |f|
    f.write(mail)
  end
  imap.store(message_id, "+FLAGS", [:Seen])
end

imap.logout

begin
  imap.disconnect
rescue Errno::ENOTCONN; end
