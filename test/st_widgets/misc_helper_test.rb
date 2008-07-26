require File.dirname(__FILE__)+'/../test_helper'

class MiscHelperTest < Test::Unit::TestCase
  include StWidgets::MiscHelper
  
  def test_menu_link
    assert_equal '<li><a href="/url">Title</a></li>', menu_link('Title', '/url')
  end
  
  def test_menu_link_current
    assert_equal '<li class="current"><a href="/current">Title</a></li>',
      menu_link('Title', '/current')
  end
  
  def flash
    { :notice => "Notice text",
      :error => "Error text",
      :info => "Info text"
    }
  end
  
  def test_flash
    assert_equal '<div id="flashes">'+
                   '<div class="info">Info text</div>'+
                   '<div class="notice">Notice text</div>'+
                   '<div class="error">Error text</div>'+
                 '</div>', flashes
  end
end
