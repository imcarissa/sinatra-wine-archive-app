require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# In order to send PATCH or DELETE requests, I will need to add a line of code here...
use Rack::MethodOverride

# Here is where I will mount other controllers with 'use'
run ApplicationController
