# frozen-string-literal: true

#
class Roda
  module RodaPlugins
    # Trace requests through your Roda application.
    module Trace
      def self.configure(app, opts={}) # :nodoc:
        app.opts[:trace] ||= {}
        app.opts[:trace][:root] ||= opts[:root] || app.opts[:root] || Dir.pwd
        app.opts[:trace][:printer] ||= opts[:printer] || Printer.new
        app.match_hook { request._record_hit }
      end

      def self.load_dependencies(app, _opts={}) # :nodoc:
        require_relative "trace/hit"
        require_relative "trace/log"

        app.plugin :match_hook
      end

      module RequestMethods
        def initialize(*)
          @_trace_log = Trace::Log.new(printer: roda_class.opts[:trace][:printer])
          super
        end

        def trace_log
          @_trace_log
        end

        def _record_hit
          callee = caller_locations.find { |location|
            next if location.path == __FILE__

            location.path.start_with?(scope.opts[:trace][:root]) || !location.path.start_with?("/")
          }

          trace_log.record Hit.new(callee.path, callee.lineno, matched_path, remaining_path)
        end
      end
    end

    register_plugin :trace, Trace
  end
end
