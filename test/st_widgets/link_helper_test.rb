require File.dirname(__FILE__)+'/../test_helper'

class LinkHelperTest < Test::Unit::TestCase
  include StWidgets::LinkHelper
  
  # tests
  def test_link_to_new
    assert_equal '<a href="/foos/new" class="new">New Foo</a>', link_to_new(:foo)
  end
  
  def test_link_to_new_big
    assert_equal '<a href="/foos/new" class="new-big">New Foo</a>', link_to_new_big(:foo)
  end
  
  def test_link_to_show
    assert_equal '<a href="/foos/1" class="show">Show</a>', link_to_show(Foo.new)
  end
  
  def test_link_to_back
    assert_equal '<a href="/foos" class="back">Back</a>', link_to_back(foos_path)
  end
  
  def test_link_to_edit
    assert_equal '<a href="/foos/1/edit" class="edit">Edit</a>', link_to_edit(Foo.new)
  end
  
  def test_link_to_destroy
    assert_equal '<a href="/foos/1" confirm="Are you sure?" method="delete"'+
      ' class="destroy">Destroy</a>', link_to_destroy(Foo.new)
  end
end
