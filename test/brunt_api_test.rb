require "test_helper"

class BruntAPITest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BruntAPI::VERSION
  end
end
