require File.expand_path('../helper', __FILE__)

class BeeminderTest < Service::TestCase
  def setup
    @stubs = Faraday::Adapter::Test::Stubs.new
  end

  def test_push
    svc = service :push, {'something' => 'abc'}, 'a' => 1
    svc.secrets = {'beeminder' => {'apikey' => 'key'}}

    @stubs.post "/github/key" do |env|
      assert_match /(^|\&)payload=%7B%22a%22%3A1%7D($|\&)/, env[:body]
      [200, {}, '']
    end

    svc.receive

    @stubs.verify_stubbed_calls
  end

  def service(*args)
    super Service::Beeminder, *args
  end
end

