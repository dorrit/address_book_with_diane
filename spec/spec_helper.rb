require 'active_record'
require 'rspec'
require 'contact'
require 'phone'
require 'email'
require 'address'
require 'shoulda-matchers'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Contact.all.each {|contact| contact.destroy}
    Phone.all.each {|phone| phone.destroy}
    Address.all.each {|address| address.destroy}
    Email.all.each {|email| email.destroy}
  end
end