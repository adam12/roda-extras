# frozen-string-literal: true

#
class Roda
  module RodaPlugins
    module Trace
      Hit = Struct.new(:path, :lineno, :matched_path, :remaining_path)
    end
  end
end
