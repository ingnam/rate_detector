require 'csv'

class CsvDataFormatter
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def format
    result = {}
    i = 0
    CSV.foreach((file_path), headers: true, col_sep: ",") do |row|
      result[i] = {timestamp: row[0], volume: row[1]}
      i = i + 1
    end
    result
  end
end