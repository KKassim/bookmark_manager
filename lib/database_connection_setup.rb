require 'database_connection.rb'
if ENV['RACK_ENV'] == 'test'
  DatabaseConnection.setup('bookmark_manager_test')
else
  DatabaseConnection.setup('bookmark_manager')
end
