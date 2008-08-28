# Include hook code here
require File.dirname(__FILE__)+"/lib/st_widgets.rb"
require File.dirname(__FILE__)+"/lib/st_widgets/misc_helper.rb"
require File.dirname(__FILE__)+"/lib/st_widgets/link_helper.rb"
require File.dirname(__FILE__)+"/lib/st_widgets/form_helper.rb"
require File.dirname(__FILE__)+"/lib/st_widgets/table_helper.rb"

ActionController::Base.class_eval { 
  helper StWidgets::MiscHelper,
         StWidgets::LinkHelper, 
         StWidgets::FormHelper, 
         StWidgets::TableHelper
}

# fake gettext initialization if there's no such thing
unless defined? GetText
  ActionView::Base.class_eval { 
    def _(text, *args)
      text
    end
  }
end
