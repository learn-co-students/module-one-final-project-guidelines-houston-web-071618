require 'bundler'
Bundler.require


require 'colorize'
require 'colorized_string'

require "sinatra/activerecord"

# config.active_record.logger = nil
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
