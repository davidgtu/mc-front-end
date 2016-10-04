module Shared
  module LiquidHelper
    def render_liquid(template)
      Liquid::Template.parse(template).render.html_safe
    end
  end
end
