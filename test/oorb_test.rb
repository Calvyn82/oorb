require "minitest/pride"
require "minitest/autorun"
require "../oorb/oorb"

class OORBTest < Minitest::Test
  def setup
    @oorb = OORB.new
  end

  def test_open_braces_are_not_allowed
    assert_raises(ArgumentError) { @oorb.build_regex("[") }
  end

  def test_close_braces_are_not_allowed
    assert_raises(ArgumentError) { @oorb.build_regex("]") }
  end

  def test_build_regex_empty_string
    assert_equal("", @oorb.build_regex(""))
  end

  def test_build_regex_no_hash_characters
    assert_equal("wuum", @oorb.build_regex("wuum"))
  end

  def test_build_regex_with_hash_characters
    assert_equal("[til4][e6cdf43][sflji385][til4]", @oorb.build_regex('test'))
  end

  def test_does_not_care_about_case_when_no_valid_characters
    assert_equal("wuum", @oorb.build_regex("WUUM"))
  end

  def test_does_not_care_about_case_when_valids
    assert_equal("[til4][e6cdf43][sflji385][til4]", @oorb.build_regex('TEST'))
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

  def test_accomodate_spaces
    assert_equal("", @oorb.escapes(""))
  end

  def test_accomodate_spaces_only_spaces
    assert_equal("\\s", @oorb.escapes("    "))
  end

  def test_accomodate_spaces_happy_path
    assert_equal("[til4][e6cdf43][sflji385][til4]\\sm[e6cdf43]",
                 @oorb.escapes("[til4][e6cdf43][sflji385][til4] m[e6cdf43]"))
  end

  def test_accomodates_punctuation
    assert_equal("[hb][il1][.,;:'`\\s]?\\\\sm[oc603d]m[.,;:'`\\s]?",
                 @oorb.escapes(
                   "[hb][il1],\\sm[oc603d]m.")
                )
  end

  def test_escapes_backslashes
    assert_equal("\\\\[hb]\\\\[il1]", @oorb.build_regex("\\h\\i"))
  end

  def test_escapes_open_parens
    assert_equal("\\(", @oorb.escapes("("))
  end

  def test_escapes_closing_parens
    assert_equal("\\)", @oorb.escapes(")"))
  end

  def test_escapes_open_curly_braces
    assert_equal("\\{", @oorb.escapes("{"))
  end

  def test_escapes_close_curly_braces
    assert_equal("\\}", @oorb.escapes("}"))
  end
end
