module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Rapture"
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
  
  
  def link_to_add_fields(name, association, f)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, [new_object], :child_index => "new_#{association}") do |builder|
      render(association.to_s + "/" + association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
end
