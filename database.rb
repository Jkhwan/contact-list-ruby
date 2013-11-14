require 'active_record'
 
# print "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database  => "db.sqlite"
)
 
# puts "CONNECTED"