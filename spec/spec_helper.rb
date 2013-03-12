require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'expense'
require 'tag'
require 'date'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Expense.all.each {|item| item.destroy}
    Tag.all.each {|item| item.destroy}
  end
end