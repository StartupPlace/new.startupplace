module StaticPagesHelper

	def nav_link(link_text, link_path, container = nil)
	  class_name = current_page?(link_path) ? 'active' : ''
	  if container == 'li'
		  content_tag(:li, :class => class_name) do
		    link_to link_text, link_path
		  end
		else
			link_to link_text, link_path, class: class_name
		end
	end

	def is_active(link_path)
	  class_name = current_page?(link_path) ? 'active' : ''
	  return class_name
	end
end
