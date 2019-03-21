require "minitest/autorun"
require "roda"

describe "opinionated plugin" do
  it "works without multi_route" do
    app = Class.new(Roda) do
      plugin :opinionated

      route do |r|
        "no multi_route"
      end
    end

    response = Rack::MockRequest.new(app).get("/")
    assert_equal "no multi_route", response.body
  end

  it "forces view subdir on named routes" do
    app = Class.new(Roda) do
      plugin :multi_route
      plugin :opinionated

      route("named") do
        @_view_subdir
      end

      route do |r|
        r.route "named"
      end
    end

    response = Rack::MockRequest.new(app).get("/")
    assert_equal "named", response.body
  end

  it "properly passes route object" do
    app = Class.new(Roda) do
      plugin :multi_route
      plugin :opinionated

      route("named") do |r|
        r.get "named" do
          "hello"
        end
      end

      route do |r|
        r.route "named"
      end
    end

    response = Rack::MockRequest.new(app).get("/named")
    assert_equal "hello", response.body
  end
end
