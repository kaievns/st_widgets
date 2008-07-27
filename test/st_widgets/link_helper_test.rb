require File.dirname(__FILE__)+'/../test_helper'

class LinkHelperTest < Test::Unit::TestCase
  include StWidgets::LinkHelper
  
  # tests
  def test_link_to_new
    assert_equal '<a class="new" href="/foos/new">New Foo</a>', link_to_new(:foo)
  end
  
  def test_link_to_new_big
    assert_equal '<a class="new-big" href="/foos/new">New Foo</a>', link_to_new_big(:foo)
  end
  
  def test_link_to_show
    assert_equal '<a class="show" href="/foos/1">Show</a>', link_to_show(Foo.new)
  end
  
  def test_link_to_back
    assert_equal '<a class="back" href="/foos">Back</a>', link_to_back(foos_path)
  end
  
  def test_link_to_edit
    assert_equal '<a class="edit" href="/foos/1/edit">Edit</a>', link_to_edit(Foo.new)
  end
  
  def test_link_to_destroy
    assert_equal '<a class="destroy" confirm="Are you sure?" href="/foos/1"'+
      ' method="delete">Destroy</a>', link_to_destroy(Foo.new)
  end
end
