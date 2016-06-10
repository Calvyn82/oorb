OCR_DATA = "../ocr_data/ocr_data.txt"

class OCRTesting
  def initialize(file: OCR_DATA)
    @test_file    ||= set_test_file(file)
    @data         ||= File.open(@test_file, 'r')
    @transposed   ||= Hash.new
    @spaces       ||= Hash.new(0)
    @combined     ||= Hash.new
    build_hashes
  end

  attr_reader :test_file, :data, :transposed, :spaces, :combined

  private

  def set_test_file(file)
    if File.exist?(file)
      file
    else
      puts "File not found. Defaulting to /ocr_data/ocr_data.txt"
      OCR_DATA
    end
  end

  def build_hashes
    @data.each_line do |line|
      segments = line.split(/\s+/)
      if segments[0].length == segments[1].length
        add_to_transposed(segments)
      else
        add_to_others(segments)
      end
    end
  end

  def add_to_transposed(segments)
    letter_pairs = segments[0].chars.zip(segments[1].chars)
    letter_pairs.each do |array|
      correct_letter = array[1]
      compare_letter = array[0]
      if correct_letter != compare_letter
        if @transposed[correct_letter]
          if @transposed[correct_letter][compare_letter]
            @transposed[correct_letter][compare_letter] += 1
          else
            @transposed[correct_letter][compare_letter] = 1
          end
        else
          @transposed[correct_letter] = {compare_letter => 1}
        end
      end
    end
  end

  def add_to_others(segments)
    correct_letters = segments[1].chars
    bad_letters     = segments[0].chars
    if bad_letters.length > correct_letters.length
      add_to_combined(correct_letters, bad_letters)
    else
      add_to_spaces(correct_letters, bad_letters)
    end
  end

  def add_to_combined(good, bad)
    key    = good.select { |x| !bad.include?(x) }[0]
    values = bad.select { |x| !good.include?(x) }
    if @combined[key]
      values.each { |x| @combined[key] << x }
      @combined[key].uniq!
    else
      @combined[key] = values
    end
  end

  def add_to_spaces(good, bad)
    key = good.select { |x| !bad.include?(x) }[0]
    @spaces[key] += 1
  end
end
