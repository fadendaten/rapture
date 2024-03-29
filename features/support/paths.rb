module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      root_path
      
    when /the customers page/
      customers_path
      
    when /the new customer page/
      new_customer_path
      
    when /the signin page/
      new_user_session_path
         
    when /path "(.+)"/
      path_to_pickle $1
      
    when /the show page for (.+)/
      polymorphic_path(model($1))
      
    when /the new page for a label/
      new_label_path()
      
    when /the new size page/
      new_size_path()
      
    when /the new size list page/
      new_size_list_path()
      
    when /the profile's edit page/
      edit_profile_path()
      
    when /the (.+) page for (.+)/
      polymorphic_path(model($2), :action => $1)



    # # the following are examples using path_to_pickle
    # 
    # when /^#{capture_model}(?:'s)? page$/                           # eg. the forum's page
    #   path_to_pickle $1
    # 
    # when /^#{capture_model}(?:'s)? #{capture_model}(?:'s)? page$/   # eg. the forum's post's page
    #   path_to_pickle $1, $2
    # 
    # when /^#{capture_model}(?:'s)? #{capture_model}'s (.+?) page$/  # eg. the forum's post's comments page
    #   path_to_pickle $1, $2, :extra => $3                           #  or the forum's post's edit page
    # 
    # when /^#{capture_model}(?:'s)? (.+?) page$/                     # eg. the forum's posts page
    #   path_to_pickle $1, :extra => $2                               #  or the forum's edit page

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)