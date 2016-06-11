require "oorb/version"
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
# OCR Optimized Regex Builder
class OORB
  def initialize
    @letters = LETTERS
  end

  attr_reader :letters

  ##
  # Runs the application from the command line
  def run
    puts "Waiting for a statement."
    user_input = gets.chomp
    puts build_regex(user_input)
    run
  end

  ##
  # Builds an OCR optimized regular expression from a string
  def build_regex(input)
    if input =~ /[\[\]]/
      raise ArgumentError, "Square braces? Really!? Fuck off."
    end
    statement = input.downcase.chars.map do |l|
      LETTERS.has_key?(l) ? build_collection(l) : l
    end.join
    escapes(statement)
  end

  ##
  # Builds a group match from an input letter
  # Raises an argument error if the letter isn't from the LETTERS hash
  def build_collection(letter)
    unless LETTERS[letter]
      raise ArgumentError, "Valid arguments are #{LETTERS.keys.join(", ")}."
    end
    LETTERS[letter].each { |x| letter << x }
    "[#{letter}]"
  end

  ##
  # Escapes backslashes, whitespace, punctuation, parens and curly braces
  # Square brackets are forbidden
  def escapes(string)
    string.gsub(/\\/, "\\\\\\")          # escape backslashes
      .gsub(/\s+/, "\\s")                # make whitespace \s
      .gsub(/[.,;:'`]/, "[.,;:'`\\s]?")  # make punction optional
      .gsub(/\(/, "\\(")                 # escape open parens
      .gsub(/\)/, "\\)")                 # escape close parens
      .gsub(/\{/, "\\{")                 # escape open curly braces
      .gsub(/\}/, "\\}")                 # escape open curly braces
  end
end
