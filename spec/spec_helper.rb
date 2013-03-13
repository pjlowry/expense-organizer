require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'factory_girl'
require './spec/factories'
require 'expense'
require 'pairing'
require 'tag'
require 'date'
require 'money'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Expense.all.each {|item| item.destroy}
    Tag.all.each {|item| item.destroy}
    Pairing.all.each {|item| item.destroy}
  end
end