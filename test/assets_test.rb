require 'test_helper'
require 'typescript-rails'

class AssetsTest < ActiveSupport::TestCase
  def setup
    require "rails"
    require 'tzinfo'
    require "action_controller/railtie"
    require "sprockets/railtie"

    @app = Class.new(Rails::Application)
    @app.config.active_support.deprecation = :stderr
    @app.config.assets.enabled = true
    @app.config.assets.cache_store = [ :file_store, "#{tmp_path}/cache" ]
    @app.paths["log"] = "#{tmp_path}/log/test.log"
    @app.initialize!
  end

  def teardown
    FileUtils.rm_rf "#{tmp_path}/cache"
    FileUtils.rm_rf "#{tmp_path}/log"
    #File.delete "#{tmp_path}/typescript.js"
  end

  test "typescript.js is included in Sprockets environment" do
    @app.assets["typescript"].write_to("#{tmp_path}/typescript.js")

    assert_match "/lib/assets/javascripts/typescript.js.erb", @app.assets["typescript"].pathname.to_s
    assert_match "var TypeScript", File.open("#{tmp_path}/typescript.js").read
  end

  def tmp_path
    "#{File.dirname(__FILE__)}/tmp"
  end
end