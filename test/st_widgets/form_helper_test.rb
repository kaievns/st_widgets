require File.dirname(__FILE__)+'/../test_helper'

class FormHelperTest < Test::Unit::TestCase
  include StWidgets::FormHelper
  
  # some additional fake helpers
  def submit_tag(title, options={ })
    tag :input, options.merge({ :type => 'submit', :value => title })
  end
  
  def label(object, method, text=nil, options={ })
    text ||= "#{method.to_s.capitalize}"
    content_tag :label, text, options.merge(:for => "#{object}_#{method}")
  end
  
  def text_field(object, method, options={ })
    tag :input, options.merge(:name => "#{object}[#{method}]",
                              :id => "#{object}_#{method}",
                              :type => "text")
  end
  
  def password_field(object, method, options={ })
    tag :input, options.merge(:name => "#{object}[#{method}]",
                              :id => "#{object}_#{method}",
                              :type => "password")
  end
  
  def text_area(object, method, options={ })
    content_tag :textarea, '', options.merge(:name => "#{object}[#{method}]",
                                             :id => "#{object}_#{method}")
  end
  
  # tests
  def test_reset_button_tag
    assert_equal '<input type="reset" value="Reset"/>', reset_button_tag
  end
  
  def test_reset_button_tag_with_title_and_class
    assert_equal '<input class="reset" type="reset" value="Clear"/>', 
      reset_button_tag("Clear", :class => "reset")
  end
  
  def test_buttons_block_simple
    assert_equal '<p class="buttons">'+
                   '<input type="submit" value="Create"/>  '+
                   '<input type="reset" value="Reset"/>'+
                 '</p>', buttons_block('Create')
  end
  
  def test_buttons_block_with_options
    assert_equal '<p class="buttons">'+
                   '<input id="submit-id" type="submit" value="Create"/>  '+
                   '<input type="reset" value="Reset"/>'+
                 '</p>', buttons_block('Create', :id => 'submit-id')
  end
  
  def test_buttons_block_without_reset
    assert_equal '<p class="buttons">'+
                   '<input type="submit" value="Create"/> '+
                 '</p>', buttons_block('Create', :noreset => true)
  end
  
  def test_buttons_block_with_block
    assert_equal '<p class="buttons">'+
                   '<input type="submit" value="Create"/> some text '+
                   '<input type="reset" value="Reset"/>'+
                 '</p>', buttons_block('Create'){ 'some text' }
  end
  
  def test_form_entry
    assert_equal '<p>'+
                   '<label for="foo_bla">Bla</label> '+
                   'some input'+
                 '</p>', form_entry(:foo, :bla){ 'some input' }
  end
  
  def test_form_entry_with_custom_label
    assert_equal '<p>'+
                   '<label for="foo_bla">Custom label</label> '+
                   'some input'+
                 '</p>', form_entry(:foo, :bla, 'Custom label'){ 'some input' }
  end
  
  def test_form_entry_with_options
    assert_equal '<p class="custom">'+
                   '<label for="foo_bla">Bla</label> '+
                   'some input'+
                 '</p>', form_entry(:foo, :bla, :class => 'custom'){ 'some input' }
  end
  
  def test_form_entry_required
    assert_equal '<p class="required">'+
                   '<label for="foo_bla">Bla</label> '+
                   'some input'+
                 '</p>', form_entry(:foo, :bla, :required => true){ 'some input' }
  end
  
  def test_form_entry_required_with_custom_label_and_options
    assert_equal '<p class="bla required" id="some-id">'+
                   '<label for="foo_bla">Label</label> '+
                   'some input'+
                 '</p>', form_entry(:foo, :bla, 'Label', :required => true, 
                                    :class => 'bla', :id => 'some-id'){ 'some input' }
  end
  
  def test_form_field_block
    assert_equal '<p>'+
                   '<label for="foo_bla">Bla</label> '+
                   '<input id="foo_bla" name="foo[bla]" type="text"/>'+
                 '</p>', form_field_block(:text_field, :foo, :bla)
  end
  
  def test_form_field_block_required
    assert_equal '<p class="required">'+
                   '<label for="foo_bla">Bla</label> '+
                   '<input id="foo_bla" name="foo[bla]" type="text"/>'+
                 '</p>', form_field_block(:text_field, :foo, :bla, :required => true)
  end
  
  def test_form_field_block_with_custom_label_and_options
    assert_equal '<p class="required">'+
                   '<label for="foo_bla">Label</label> '+
                   '<input class="bla" id="foo_bla" name="foo[bla]" type="text"/>'+
                 '</p>', form_field_block(:text_field, :foo, :bla, "Label", 
                                          :required => true, :class => "bla")
  end
  
  def test_text_field_block
    assert_equal '<p>'+
                   '<label for="foo_bla">Bla</label> '+
                   '<input id="foo_bla" name="foo[bla]" type="text"/>'+
                 '</p>', text_field_block(:foo, :bla)
  end
  
  def test_password_field_block
    assert_equal '<p>'+
                   '<label for="foo_bla">Bla</label> '+
                   '<input id="foo_bla" name="foo[bla]" type="password"/>'+
                 '</p>', password_field_block(:foo, :bla)
  end
  
  def test_text_area_block
    assert_equal '<p>'+
                   '<label for="foo_bla">Bla</label> '+
                   '<textarea id="foo_bla" name="foo[bla]"></textarea>'+
                 '</p>', text_area_block(:foo, :bla)
  end
end
