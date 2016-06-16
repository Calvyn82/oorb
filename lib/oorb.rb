require "oorb/version"

##
# OCR Optimized Regex Builder
class OORB

  ##
  # Letters that regularly are mistaken in OCR and their common replacements
  LETTERS = {'a' => %w(9),
             'b' => %w(h),
             'c' => %w(e f d o 6),
             'd' => %w(3 0 o 7),
             'e' => %w(6 c d f 4 3),
             'f' => %w(c s p),
             'g' => %w(9 8),
             'h' => %w(b),
             'i' => %w(l 1),
             'j' => %w(y),
             'l' => %w(1 i t 7),
             'n' => %w(r),
             'o' => %w(c 6 0 3 d),
             'p' => %w(fr),
             'r' => %w(np),
             's' => %w(f l j i 3 8 5),
             't' => %w(i l 4 7),
             'u' => %w(v),
             'v' => %w(yu),
             'y' => %w(v j 7),
             'z' => %w(2)
  }

  ##
  # Letters that are commonly mistakenly split up and their replacements
  SECTIONS = {'m' => '[mnr][nr]?',
              'w' => '[wvu][vu]?'
  }

  ##
  # Runs the application from the command line
  def run
    puts "Waiting for a statement."
    user_input = gets.chomp
    combined = combine_whitespace(user_input)
    puts build_regex(combined)
    run
  end

  ##
  # Builds an OCR optimized regular expression from a string
  # @param input [String] to be parsed
  # @return [String] formatted as a valid regular expression optimized for capturing OCR mistakes
  def build_regex(input)
    input.downcase.chars.map do |char|
      if LETTERS.has_key?(char)
        build_collection(char)
      elsif SECTIONS.has_key?(char)
        build_section(char)
      else
        escape(char)
      end
    end.join
  end

  ##
  # Collapses mutliple consecutive whitespace characters into a single whitespace character
  # @param string [String] of any length
  # @return [String] where consecutive whitespace characters have been collapsed
  def combine_whitespace(string)
    string.gsub(/\s+/, "\s")
  end

  ##
  # Builds a group match from an input letter.
  # @raise [ArgumentError] if the argument isn't a single character string from OORB::LETTERS
  # @param character [String] made of a single character
  # @return [String] collection of commonly mis-ocr'd characters bounded by square brackets
  def build_collection(character)
    unless LETTERS[character]
      raise ArgumentError,
        "Valid arguments are a single character from #{LETTERS.keys.join(", ")}."
    end
    LETTERS[character].each { |x| character << x }
    "[#{character}]"
  end

  ##
  # Builds a section from an input letter.
  # @raise [ArgumentError] if the argument isn't a single character string from OORB::SECTIONS
  # @param character [String] made of a single character
  # @return [String] section of commonly split characters with optional second character
  def build_section(character)
    unless SECTIONS[character]
      raise ArgumentError,
        "Valid arguments are a single character from #{SECTIONS.keys.join(", ")}."
    end
    SECTIONS[character]
  end

  ##
  # Escapes a single-character string and makes whitespace characters optional
  # @param character [String] made of a single character
  # @return [String] escaped character with whitespace charactions made optional
  # @raise [ArgumentError] if the argument isn't a single character string
  def escape(character)
    if character.length > 1
      raise ArgumentError, "Argument must be a single character string"
    end
    character == "\s" ? "\\s?" : Regexp.escape(character)
  end

  private

  def format(character)
    if character =~ /[wm]/
      build_
    else
      Regexp.escape(character)
    end
  end
end
