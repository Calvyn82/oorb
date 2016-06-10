require "minitest/autorun"
require "../data_analysis/ocr_testing"

class OCRTestingTest < Minitest::Test
  def setup
    @script = OCRTesting.new
  end

  def test_default
    assert_equal("../ocr_data/ocr_data.txt", @script.test_file)
  end

  def test_bad_file
    @script = OCRTesting.new(file: "./fake_file.oops")
    assert_equal("../ocr_data/ocr_data.txt", @script.test_file)
  end

  def test_good_passed_file
    @script = OCRTesting.new(file: "../seeds/test_file.txt")
    assert_equal("../seeds/test_file.txt", @script.test_file)
  end

  def test_data
    assert_instance_of(File, @script.data)
  end
end
