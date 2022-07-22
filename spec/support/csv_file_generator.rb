module CsvFileGenerator
  def generate_temp_csv_file(data)
    Tempfile.new('csv').tap do |f|
      data.each do |datum|
        f << datum.join(',') + "\r"
      end

      f.close
    end
  end
end