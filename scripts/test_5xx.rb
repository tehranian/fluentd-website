ENV['RACK_ENV'] = 'test'

require './app'
require 'test/unit'
require 'rack/test'

class FluentdWebsiteTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # Test popular pages for 5xxs
  {
  	'top' => '',
  	'download' => 'download',
  	'plugins' => 'plugins',
  	'plugins_all' => 'plugins/all',
   	'what_is_fluentd' => 'architecture',
   	'why_use_fluentd' => 'why',
        'blog' => 'blog/',
	'blog_kiyoto' => 'blog/unified-logging-layer',
        'blog_masa' => 'blog/fluentd-v0.12-is-released',
        'blog_rss' => 'blog/feed.rss'	
  }.each do |k, path|
	  define_method ('test_it_'+k), Proc.new {
	  	get path; assert last_response.ok?
	  }
  end
end
