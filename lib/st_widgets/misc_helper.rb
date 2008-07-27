#
# there are misc helper methods
#
module StWidgets::MiscHelper
  #
  # compiles a menu label
  #
  # USE:
  #   <%= menu_link "Title", some_path %>
  #
  def menu_link(title, url, options={ })
    content_tag :li, link_to(title, url, options), :class => 
      request.request_uri[0, url.size] == url ? :current : nil
  end
  
  #
  # compiles the flash messages block
  #
  # USE:
  #   <%= flashes %>
  #
  def flashes
    content_tag :div, flash.collect{ |name, text|
      content_tag :div, text, :class => name
    }, :id => :flashes, :style => (flash.empty? ? 'display :none' : '')
  end
  
  #
  # analogue of div_for
  # additionally supports models inheritance
  #
  def p_for(record, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : { }
    options[:class] = record.class.name.split('::').collect{|c| c.underscore}
    options[:class].pop # removing the last name case it will be added by the dom_class method
    args.push options
    
    content_tag_for :p, record, *args, &block
  end
  
  #
  # generates various lists
  #
  # the method accepts some additional options
  #   :type => 'ul' | 'ol' | 'dl' | 'states'
  #   :escape => true|false - should the texts be escaped with the h() method or not
  #   :stripy => true|false - should the list be striped with odd/even classes or not
  #   :recoursive => true|false - should the method handle the list entries recoursive
  #
  # USE:
  #   <%= ul ['one', 'two', ['three', 'four']] %>
  # 
  #   will produce a construction like that
  #   <ul>
  #     <li class="odd">one</li>
  #     <li class="even">two</li>
  #     <ul>
  #       <li class="odd">three</li>
  #       <li class="even">four</li>
  #     </ul>
  #   </ul>
  #
  #   if you pass an option :type => 'states', then the method will treat
  #   each entry as a pair like [name, value], the name will be used for 
  #   the text, the value will be checked as a boolean value and additional
  #   class will be added to the item, so you could see which item is true
  #   and which is falsed.
  #
  #   <%= ul [['one', true], ['two', false]], :type => 'states' %>
  #
  #   will create a code like that
  #   <ul class="states">
  #     <li class="odd true">one</li>
  #     <li class="even false">two</li>
  #   </ul>
  #   
  def ul(list, options={ })
    options = { 
      :type => :ul, # ol, dl, states
      :escape => true,
      :stripy => true,
      :recoursive => true
    }.merge(options)
    
    options[:type] = options[:type].to_s.downcase
    if options[:type] == 'states'
      options[:class] ||= ''
      options[:class] = options[:class] =~ /^\s*$/ ? 'states' : "#{options[:class]} states"
    end
    
    # getting the list tag
    tag_name = case options[:type]
               when 'ol' then 'ol'
               when 'dl' then 'dl'
               else           'ul'
               end
    
    # compiling the list
    content_tag tag_name, list.collect { |item|
      # check if the current item is a state-list item
      state_item = options[:type] == 'states' and item.is_a?(Array) and item.size == 2
      
      # check if there's a recoursive list
      if item.is_a?(Array) and options[:recoursive] and !state_item
        ul(item, {
             :type => options[:type],
             :escape => options[:escape],
             :stripy => options[:stripy],
             :recoursive => options[:recoursive]
           })
      else
        # compiling the list-item classes list
        classes = []
        classes << cycle('odd', 'even') if options[:stripy]
        classes << item[1] ? 'true' : 'false' if state_item
        
        text = (state_item ? item[0] : item).to_s
        
        # compiling the list-item
        content_tag(tag_name=='dl' ? 'dd' : 'li', 
                    options[:escape] ? h(text) : text,
                    :class => classes.empty? ? nil : classes.join(' '))
      end
    }, options.reject{ |k, v| [:type, :escape, :stripy, :recoursive].include?(k) }
  end
end
