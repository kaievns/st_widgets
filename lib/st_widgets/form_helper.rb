#
# This is the form elements helpers collection
#
module StWidgets::FormHelper
  #
  # Generates a reset button with the given title and options
  #
  def reset_button_tag(title=nil, options={ })
    title = _("Reset") unless title
    tag :input, { :type => 'reset', :value => title }.merge(options)
  end
  
  #
  # generates a full buttons block
  #
  # USE:
  #   This method can be used in several ways
  #
  #   the general example is following
  #   <%= buttons_block "Update" %>
  #
  #   this will generate a code like
  #   <p class="buttons">
  #     <input type="submit" value="Update" />
  #     <input type="reset" value="Reset" />
  #   </p>
  #
  #   if you don't need the reset button passe the :noreset option
  #   <%= buttons_block "Update", :noreset => true %>
  #
  #   Then you can pass a block to the method
  #   <% buttons_block "Update" do -%>
  #     <input type="button" value="Special Button"/>
  #   <% end -%>
  #
  #   This will produce a code like
  #   <p class="buttons">
  #     <input type="submit" value="Update" />
  #     <input type="button" value="Special Button"/>
  #     <input type="reset" value="Reset" />
  #   </p>
  #
  #   Or, if you like you may skip the basic submit button as well
  #   just don't pass it's title
  #   <% buttons_block do -%>
  #     <input type="button" value="Special Button"/>
  #   <% end -%>
  #
  #   This will produce a code like
  #   <p class="buttons">
  #     <input type="button" value="Special Button"/>
  #     <input type="reset" value="Reset" />
  #   </p>
  #
  def buttons_block(submit_caption=nil, options={ }, &block)
    if options[:noreset]
      options.delete :noreset
      reset = ''
    else
      reset = ' ' + reset_button_tag
    end
    submit = submit_caption ? submit_tag(submit_caption, options)+' ' : ''
    
    options = { :class => 'buttons' }
    
    if block_given?
      concat content_tag(:p, submit + capture(&block) + reset, options), block.binding
    else
      content_tag(:p, submit + reset, options)
    end
  end
  
  #
  # generates a form entry block
  #
  # USE:
  #   <% form_entry :object, :method do -%>
  #     <%= text_field_tag :object, :method %>
  #   <% end -%>
  #
  #   will produce
  #   <p>
  #     <label for="object_method">Method</label>
  #     <input type="text" name="object[method]" id="object_method" />
  #   </p>
  #
  #   you can mark the entry as a required one
  #   <% form_entry :object, :method, :required => true do -%>
  #     <%= text_field_tag :object, :method %>
  #   <% end -%>
  #
  #   will produce
  #   <p class="required">
  #     <label for="object_method">Method</label>
  #     <input type="text" name="object[method]" id="object_method" />
  #   </p>
  #
  #   or you can specify custom label and options
  #
  #   <% form_entry :object, :method, "Label", :id => 'the-entry' do -%>
  #     <%= text_field_tag :object, :method %>
  #   <% end -%>
  #
  #   will produce
  #   <p id="the-entry">
  #     <label for="object_method">Label</label>
  #     <input type="text" name="object[method]" id="object_method" />
  #   </p>
  #
  def form_entry(object, method, *args, &block)
    text = args.first.is_a?(String) ? args.shift : nil
    options = args.last.is_a?(Hash) ? args.pop : { }
    
    if options[:required]
      options[:class] = options[:class] ? "#{options[:class]} required" : "required"
      options.delete :required
    end
    
    # execute the block
    begin
      concat content_tag(:p, label(object, method, text)+' '+
                       capture(&block), options), block.binding
    rescue
      content_tag(:p, label(object, method, text)+' '+yield(), options)
    end
  end
  
  #
  # general form-field block generator helper
  # creates a form-entry with an input element of the given type
  #
  # NOTE: will pass the options argument to the input element
  #       _not_ to the block element
  #
  # USE:
  #    <%= form_field_block :text_field_tag, :foo, :bla, :class => 'foo' %>
  #
  #    will produce the following code
  #    <p>
  #      <label for="foo_bla">Bla</label>
  #      <input type="text" name="foo[bla]" id="foo_bla" />
  #    </p>
  #
  def form_field_block(type, object, method, *args)
    text = args.first.is_a?(String) ? args.shift : nil
    options = args.last.is_a?(Hash) ? args.pop : { }
    
    entry_options = { }
    if options[:required]
      entry_options[:required] = options[:required]
      options.delete :required
    end
    
    form_entry(object, method, text, entry_options) { 
      send(type, object, method, options) }
  end
  
  #
  # shortcut, generates a form-entry with the input element
  # of the text-field type
  #
  def text_field_block(object, method, *args)
    form_field_block :text_field, object, method, *args
  end
  
  #
  # shortcut, generates a form-entry with the input element
  # of the passwrod-field type
  #
  def password_field_block(object, method, *args)
    form_field_block :password_field, object, method, *args
  end
  
  # shortcut, generates a form-entry with the input element
  # of the text-area type
  def text_area_block(object, method, *args)
    form_field_block :text_area, object, method, *args
  end
end