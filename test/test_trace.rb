require "minitest/autorun"
require "roda"

describe "trace plugin" do
  it "records hits" do
    app = Class.new(Roda) do
      plugin :trace

      route do |r|
        r.get "traced" do
          r.trace_log.hit_count.to_s
        end
      end
    end

    response = Rack::MockRequest.new(app).get("/traced")

    assert_equal "1", response.body
  end

  it "accepts a printer" do
    class FakePrinter
      attr_accessor :printed

      def initialize
        self.printed = false
      end

      def print(_)
        self.printed = true
      end
    end

    printer = FakePrinter.new

    app = Class.new(Roda) do
      plugin :trace, printer: printer

      route do |r|
        r.get "traced" do
          r.trace_log.print
          "traced"
        end
      end
    end

    response = Rack::MockRequest.new(app).get("/traced")
    assert_equal "traced", response.body
    assert printer.printed
  end
end
