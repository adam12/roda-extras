# frozen-string-literal: true

#
class Roda
  module RodaPlugins
    module Trace
      class Printer
        def print(hits)
          hits.each_with_index do |hit, depth|
            remaining_path = hit.remaining_path.to_s.strip != "" ? hit.remaining_path : "nothing"
            puts "  " * depth + "→ #{hit.matched_path} hit by #{hit.path}:#{hit.lineno} (#{remaining_path} remaining)"
          end
        end
      end
    end
  end
end
