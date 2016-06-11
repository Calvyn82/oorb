require "oorb/version"

##
# OCR Optimized Regex Builder
class OORB

  ##
  # Letters that regularly are mistaken in OCR and their common replacements
  LETTERS = {'s' => %w(f l j i 3 8 5),
             'h' => %w(b),
             'b' => %w(h),
             'y' => %w(v j 7),
             'c' => %w(e f d o 6),
             'i' => %w(l 1),
             'e' => %w(6 c d f 4 3),
             'o' => %w(c 6 0 3 d),
             't' => %w(i l 4),
             'a' => %w(9),
             'l' => %w(1 i t),
             'v' => %w(y),
             'f' => %w(c s),
             'd' => %w(3 0 o),
             'z' => %w(2),
             'g' => %w(9 8),
             'j' => %w(y),
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
  def build_regex(input)
    input.downcase.chars.map do |char|
      LETTERS.has_key?(char) ? build_collection(char) : escape(char)
    end.join
  end

  ##
  # Collapses mutliple consecutive whitespace characters into a single whitespace character
  def combine_whitespace(string)
    string.gsub(/\s+/, "\s")
  end

  ##
  # Builds a group match from an input letter. 
  # Raises an argument error if the letter isn't from the LETTERS hash
  def build_collection(character)
    unless LETTERS[character]
      raise ArgumentError, "Valid arguments are a single character from #{LETTERS.keys.join(", ")}."
    end
    LETTERS[character].each { |x| character << x }
    "[#{character}]"
  end

  ##
  # Escapes a single-character string and makes whitespace characters optional
  def escape(character)
    if character.length > 1
      raise ArgumentError, "Argument must be a single character string"
    end
    character == "\s" ? "\\s?" : Regexp.escape(character)
  end
end
