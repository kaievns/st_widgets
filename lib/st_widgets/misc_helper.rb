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
  
  # analogue of div_for
  def p_for(record, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : { }
    options[:class] = record.class.name.split('::').collect{|c| c.underscore}
    options[:class].pop # removing the last name case it will be added by the dom_class method
    args.push options
    
    content_tag_for :p, record, *args, &block
  end
end
