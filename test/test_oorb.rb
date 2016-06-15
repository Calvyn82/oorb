require_relative "test_helper"

class OORBTest < Minitest::Test
  def setup
    @oorb = OORB.new
  end

  def test_build_regex_empty_string
    assert_equal("", @oorb.build_regex(""))
  end

  def test_build_regex_no_hash_characters
    assert_equal("wm", @oorb.build_regex("wm"))
  end

  def test_build_regex_with_hash_characters
    assert_equal("[til4][e6cdf43][sflji385][til4]", @oorb.build_regex("test"))
  end

  def test_does_not_care_about_case_when_no_collection_characters
    assert_equal("wm", @oorb.build_regex("WM"))
  end

  def test_does_not_care_about_case_when_collection_characters
    assert_equal("[til4][e6cdf43][sflji385][til4]", @oorb.build_regex("TEST"))
  end

  def test_combine_whitespace
    assert_equal("\s", @oorb.combine_whitespace("    "))
  end

  def test_build_collection_empty_string
    assert_raises(ArgumentError) { @oorb.build_collection("") }
  end

  def test_build_collection_invalid_character
    assert_raises(ArgumentError) { @oorb.build_collection("x") }
  end

  def test_build_collection_valid_character
    assert_equal("[hb]", @oorb.build_collection("h"))
  end

  def test_build_collection_more_results
    assert_equal("[sflji385]", @oorb.build_collection("s"))
  end

  def test_escape_raises_ArgumentError
    assert_raises(ArgumentError) { @oorb.escape("more than one character") }
  end

  def test_escape_escapes_whitespace
    assert_equal("\\s?", @oorb.escape(" "))
  end

  def test_escape_backslashes
    assert_equal("\\\\", @oorb.escape("\\"))
  end

  def test_escape_open_square_braces
    assert_equal("\\[", @oorb.escape("["))
  end

  def test_escape_close_square_braces
    assert_equal("\\]", @oorb.escape("]"))
  end

  def test_escape_open_parens
    assert_equal("\\(", @oorb.escape("("))
  end

  def test_escape_closing_parens
    assert_equal("\\)", @oorb.escape(")"))
  end

  def test_escape_open_curly_braces
    assert_equal("\\{", @oorb.escape("{"))
  end

  def test_escape_close_curly_braces
    assert_equal("\\}", @oorb.escape("}"))
  end
end
