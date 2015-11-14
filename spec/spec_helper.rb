require('rspec')
require('pg')
require('capybara/rspec')
require('client')
require('stylist')

DB = PG.connect({:dbname => "salon_test"})

RSpec.configure() do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
    DB.exec("DELETE FROM clients *;")
  end
end

@@create_client = lambda do |attributes|
  base = {:last_name => '', :first_name => '', :stylist_id => 0, :id => nil}
  base.merge!(attributes)
  Client.new(base)
end

@@create_stylist = lambda do |attributes|
  base = {:last_name => '', :first_name => '', :client_id => 0, :id => nil}
  base.merge!(attributes)
  Stylist.new(base)
end