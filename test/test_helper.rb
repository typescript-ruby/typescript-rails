# Configure coveralls environment

require 'coveralls'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter '.bundle/'
end

# Configure Rails environment
ENV['RAILS_ENV'] = 'test'

require 'rails'
require 'rails/test_help'
require 'minitest-power_assert'

# For generators
require 'rails/generators/test_case'

def copy_routes
  routes = File.expand_path('../support/routes.rb', __FILE__)
  destination = File.join(destination_root, 'config')

  FileUtils.mkdir_p(destination)
  FileUtils.cp routes, destination
end