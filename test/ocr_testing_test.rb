require "minitest/autorun"
require "../data_analysis/ocr_testing"

class OCRTestingTest < Minitest::Test
  def setup
    @script = OCRTesting.new
  end

  def test_run
    assert_equal "Running", @script.run
  end
end
