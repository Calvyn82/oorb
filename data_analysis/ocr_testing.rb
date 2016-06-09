OCR_DATA = "../ocr_data/ocr_data.txt"

class OCRTesting

  def run
    File.exist?(OCR_DATA) ? "Running" : "File not found"
  end
end
