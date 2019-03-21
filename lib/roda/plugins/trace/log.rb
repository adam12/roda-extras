# frozen-string-literal: true

#
class Roda
  module RodaPlugins
    module Trace
      class Log
        require_relative "printer"

        attr_accessor :printer
        attr_accessor :hits

        def initialize(printer: Printer.new)
          self.hits = []
          self.printer = printer
        end

        def record(hit)
          fail ArgumentError, "expected Hit. Received #{hit.class}" unless Hit === hit
          hits << hit
        end

        def print
          printer.print(hits)
        end

        def hit_count
          hits.size
        end

        private

        attr_accessor :hits
      end
    end
  end
end
