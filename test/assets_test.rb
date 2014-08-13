require 'test_helper'
require 'typescript-rails'

require "action_controller/railtie"
require "sprockets/railtie"


class AssetsTest < ActiveSupport::TestCase
  include Minitest::PowerAssert::Assertions

  def setup
    FileUtils.mkdir_p tmp_path

    @app = Class.new(Rails::Application)

    @app.config.eager_load = false
    @app.config.active_support.deprecation = :stderr
    @app.config.assets.configure do |env|
      env.cache = ActiveSupport::Cache.lookup_store(:memory_store)
    end
    @app.config.assets.paths << "#{File.dirname(__FILE__)}/fixtures/assets"
    @app.paths["log"] = "#{tmp_path}/log/test.log"
    @app.initialize!
  end

  def teardown
    FileUtils.rm_rf tmp_path
  end

  def tmp_path
    "#{File.dirname(__FILE__)}/tmp"
  end

  def assets
    @app.assets
  end

  test "typescript.js is included in Sprockets environment" do
    assert { assets["typescript"].pathname.to_s.end_with?('/lib/assets/javascripts/typescript.js.erb') }
    assert { assets["typescript"].body.include?('var TypeScript') }
  end

  test "assets .js.ts is compiled from TypeScript to JavaScript" do
    assert { assets["javascripts/hello"].present? }
    assert { assets["javascripts/hello"].body.include?('var s = "Hello, world!";') }
  end
end