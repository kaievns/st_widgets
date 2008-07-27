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
  
  def test_ul
    assert_equal '<ul>'+
                   '<li class="odd">one</li>'+
                   '<li class="even">two</li>'+
                   '<li class="odd">three</li>'+
                 '</ul>', ul(%w{one two three})
  end
  
  def test_ul_without_striping
    assert_equal '<ul>'+
                   '<li>one</li>'+
                   '<li>two</li>'+
                   '<li>three</li>'+
                 '</ul>', ul(%w{one two three}, :stripy => false)
  end
  
  def test_ul_of_ol
    assert_equal '<ol>'+
                   '<li>one</li>'+
                   '<li>two</li>'+
                   '<li>three</li>'+
                 '</ol>', ul(%w{one two three}, :stripy => false, :type => :ol)
  end
  
  def test_ul_of_dl
    assert_equal '<dl>'+
                   '<dd>one</dd>'+
                   '<dd>two</dd>'+
                   '<dd>three</dd>'+
                 '</dl>', ul(%w{one two three}, :stripy => false, :type => :dl)
  end
  
  def test_ul_recoursive
    assert_equal '<ul>'+
                   '<li>a</li>'+
                   '<li>b</li>'+
                   '<ul>'+
                     '<li>c</li>'+
                     '<ul>'+
                       '<li>d</li>'+
                       '<li>e</li>'+
                     '</ul>'+
                   '</ul>'+
                 '</ul>', ul(['a', 'b', ['c', ['d', 'e']]], :stripy => false)
  end
  
  def test_ul_of_states
    assert_equal '<ul class="states">'+
                   '<li class="odd true">a</li>'+
                   '<li class="even true">b</li>'+
                   '<li class="odd false">c</li>'+
                 '</ul>', ul([['a', true], ['b', true], 
                              ['c', false]], :type => :states)
  end
end
