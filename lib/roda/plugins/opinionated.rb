# frozen-string-literal: true

#
class Roda
  module RodaPlugins
    # Force a few opinions on Roda
    module Opinionated
      module ClassMethods
        def route(name=nil, namespace=nil, &block)
          if name && block
            return super { |r|
              append_view_subdir(name)
              instance_exec(r, &block)
            }
          end

          super(&block)
        end
      end

      def self.load_dependencies(app, _opts={}) # :nodoc:
        app.plugin :view_options
      end
    end

    register_plugin :opinionated, Opinionated
  end
end
