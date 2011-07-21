Cherrypicker - A user-interface experiment in bacn intercepting.

== Getting Installed (OS X) ==

Make sure you are setup to develop [Rails Applications](http://developer.apple.com/tools/developonrailsleopard.html)

``
  sudo gem update --system
  sudo gem install rails
  sudo gem update rake
  sudo gem update sqlite3-ruby
``

Have MySQL installed

`brew install mysql`

Bundle install the sift.mozillalabs.com app

``
  cd apps/sift.mozillalabs.com/
  bundle install
``

Bundle install the mail_processor app

``
  cd apps/mail_processor/
  bundle install
``

== Getting Setup ==

MySQL will need to be initialized, see `brew info mysql` for instructions to setup databases to run AS YOUR USER ACCOUNT

Once initialized run the MySQL server.

`mysql.server start`

== Configure Sift Server ==

``
  cd apps/sift.mozillalabs.com/config/
  cp database.yml.sample database.yml
``

== Initialize Sift database ==

Create the database tables. _This will error if MySQL is not running_

``
  cd apps/sift.mozillalabs.com/
  bundle exec rake db:create
``

Load the schema to the development database.

``
  cd apps/sift.mozillalabs.com/
  bundle exec rake db:schema:load
``

== Configure Mail Processor ==

Edit the `mail_fetcher.yml` file username and folder entry to match your email server

``
  cd apps/mail_processor/config
  cp mail_fetcher.yml.sample mail_fetcher.yml
  open mail_fetcher.yml
``

Download Fixtures from your email server

``
  cd apps/mail_processor
  ruby bin/pluck_gmail_bacns.rb
``

Processing Fixtures

``
  cd apps/sift.mozillalabs.com/
  for f in `ls ../mail_processor/fixtures/`; do ./script/process_mail.rb ../mail_processor/fixtures/$f; done
``

== Getting Running ==

``
  cd apps/sift.mozillalabs.com/
  ./script/rails server
``
