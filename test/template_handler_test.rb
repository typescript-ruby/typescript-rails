require File.join(File.dirname(__FILE__), 'test_helper.rb')
require 'action_controller'
require 'typescript-rails'

class SiteController < ActionController::Base
  self.view_paths = File.expand_path('../fixtures', __FILE__)
end

DummyApp = ActionDispatch::Routing::RouteSet.new
DummyApp.draw do
  get 'site/index'
  get 'site/ref1_1'
  get 'site/ref1_2'
  get 'site/ref2_1'
  get 'site/ref2_2'
  get 'site/ref3_1'
  get 'site/es5'
end

class TemplateHandlerTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    @app ||= DummyApp
  end

  def source
    # source without comments
    last_response.body.gsub(%r{^//[^\n]*}m, '')
  end

  test 'typescript views are served as javascript' do
    get '/site/index.js'
    assert_match /var x = 5;\s*/,
        source
  end

  test '<reference> to other .ts file works' do
    get '/site/ref1_2.js'
    assert_match /var f = function \(x, y\) \{\s*return x \+ y;\s*\};\s*f\(1, 2\);\s*/,
        source
  end

  test '<reference> to other .d.ts file works' do
    get '/site/ref2_2.js'
    assert_match /f\(1, 2\);\s*/,
        source
  end

  test '<reference> to multiple .ts files works' do
    get '/site/ref3_1.js'
    assert_match /var f1 = function \(\) \{\s*\};\s*var f2 = function \(\) \{\s*\};\s*f1\(\);\s*f2\(\);/,
        source
  end

  test 'ES5 features' do
    get '/site/es5.js'
    assert_equal 200, last_response.status
  end
end
