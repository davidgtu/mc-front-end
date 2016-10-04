module Shared
  module NameFormatHelper
    def name_or_none(model)
      model ? model.name : 'None'
    end
  end
end
