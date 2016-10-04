module Shared
  module JbuilderHelper
    def render_json(template)
      template = "#{template}.jbuilder"
      controller.render(template: template).html_safe
    end
  end
end
