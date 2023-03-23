module ApplicationHelper
	def action_link(name, icon, options = {}, html_options = {})
		html_options = html_options.merge!({
			class: "btn btn-link action-link"
		})

		link_to options, html_options do
			[
				content_tag(:i, "", class: "bi #{icon} small"),
				content_tag(:span, name, class: "ms-1")
			].join('').html_safe
		end
	end
end
