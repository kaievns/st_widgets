require 'test/unit'

require File.dirname(__FILE__)+'/../lib/st_widgets'
require File.dirname(__FILE__)+'/../lib/st_widgets/misc_helper'
require File.dirname(__FILE__)+'/../lib/st_widgets/link_helper'
require File.dirname(__FILE__)+'/../lib/st_widgets/form_helper'
require File.dirname(__FILE__)+'/../lib/st_widgets/table_helper'

module FakeHelpers
  def tag(tag, options={ })
    "<#{tag}#{options_str(options)}/>"
  end
  
  def content_tag(tag, content, options={ })
    "<#{tag}#{options_str(options)}>#{content}</#{tag}>"
  end
  
  def link_to(title, url, options={ })
    url = foo_path(url) unless url.is_a? String
    
    content_tag :a, title, { :href => url }.merge(options)
  end
  
  def options_str(options)
    options = options.sort {|a,b| a[0].to_s == 'href' ? -1 : 1
                }.collect{ |k, v| "#{k}=\"#{v}\"" 
                }.select{ |s| s[-3,s.size] != '=""'}.join(' ')
    options = ' ' + options if options.size > 0
    options
  end
  
  def capture(&block)
    yield()
  end
  
  def concat(string, binding)
    string
  end
end

class FakeRequest
  def request_uri
    '/current/uri'
  end
end

class Test::Unit::TestCase
  include FakeHelpers
  
  def _(str)
    str
  end
  
  def request
    FakeRequest.new
  end
  
  # fake path generators
  def foos_path
    '/foos'
  end
  
  def new_foo_path
    '/foos/new'
  end
  
  def foo_path(foo)
    '/foos/1'
  end
  
  def edit_foo_path(foo)
    '/foos/1/edit'
  end
end

module ActiveRecord
  class Base
  end
end

class Foo < ActiveRecord::Base
end
