require 'test_helper'
require 'action_controller'
require 'typescript-rails'

class SiteController < ActionController::Base
  self.view_paths = File.expand_path("../support", __FILE__)
end

DummyApp = ActionDispatch::Routing::RouteSet.new
DummyApp.draw do
  get "site/index"
  get "site/ref1_1"
  get "site/ref1_2"
  get "site/ref2_1"
  get "site/ref2_2"
end

class TemplateHandlerTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    @app ||= DummyApp
  end

  test "typescript views are served as javascript" do
    get "/site/index.js"

    assert_match "var x = 5;\r\n", last_response.body
  end

  test "<reference> to other .ts file works" do
    get "/site/ref1_2.js"
    assert_match "var f = function (x, y) {\r\n    return x + y;\r\n};\r\nf(1, 2);\r\n", last_response.body
  end

  test "<reference> to other .d.ts file works" do
    get "/site/ref2_2.js"
    assert_match "f(1, 2);\r\n", last_response.body
  end

end
