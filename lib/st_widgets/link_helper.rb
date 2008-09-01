#
# There are various links shortcuts
#
module StWidgets::LinkHelper
  #
  # This method will create a link to new element
  #
  # USE:
  #   link_to_new :user
  #
  #   will do the same as
  #
  #   link_to "New User", new_user_path, :class => 'new'
  #
  def link_to_new(key, options={ })
    link_to _("New %s") % key.to_s.capitalize, send("new_#{key}_path"), { 
      :class => 'new' }.merge(options)
  end
  
  #
  # creates a big link to new element
  #
  # USE:
  #  link_to_new_big :user
  #
  #  will do the same as
  #
  #  link_to "New User", new_user_path, :class => "new-big"
  #
  def link_to_new_big(key, options={ })
    link_to_new key, { :class => "new-big" }.merge(options)
  end
  
  #
  # This method creates a link to item show page
  #
  # USE:
  #   link_to_show @user
  #
  #   will do the same as
  #
  #   link_to "Show", @user, :class => 'show'
  #
  def link_to_show(url, options={ })
    link_to _('Show'), url, { :class => 'show' }.merge(options)
  end
  
  #
  # generates the link to back
  #
  # USE:
  #   link_to_back users_path
  #
  #   will do the same as
  #
  #   link_to "Back", @user, :class => 'back'
  #
  def link_to_back(url, options={ })
    link_to _('Back'), url, { :class => 'back' }.merge(options)
  end
  
  #
  # Creates a link to the item edit page
  #
  # USE:
  #   link_to_edit @user
  #
  #   will do the same as
  #
  #   link_to "Edit", edit_user_path(@user), :class => 'edit'
  #
  def link_to_edit(url, options={ })
    url = send("edit_#{url.class.name.downcase}_path", url) if url.is_a?(ActiveRecord::Base)
    link_to _('Edit'), url, { :class => 'edit' }.merge(options)
  end
  
  #
  # Creates a link to destroy the item
  #
  # USE:
  #   link_to_destroy @user
  #
  #   will do the same as
  #
  #   link_to "Destroy", @user, :confirm => "Are you sure?", :method => :delete, :class => 'destroy'
  #
  def link_to_destroy(url, options={ })
    link_to _('Destroy'), url, { :class => 'destroy', 
      :confirm => _('Are you sure?'), :method => :delete }.merge(options)
  end
  
  alias :link_to_delete :link_to_destroy
end
