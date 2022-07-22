require_relative 'csv_data_formatter'
require 'time'

class RateDetector
  attr_accessor :file_path, :rate_of_change, :volume_data

  def initialize(file_path, rate_of_change)
    @file_path = file_path
    @rate_of_change = rate_of_change.to_i
    @volume_data = CsvDataFormatter.new(file_path).format
  end

  def detect_changes
    changed_indexes = []
    volume_data.each do |index, volume_datum|
      next if index == 0
      prev_volume_datum = volume_data[index - 1]
      time_diff = time_diff_in_mins(prev_volume_datum[:timestamp], volume_datum[:timestamp])
      volume_diff = prev_volume_datum[:volume].to_i - volume_datum[:volume].to_i
      change_rate = (volume_diff/time_diff).abs
      changed_indexes << index if change_rate >= rate_of_change
    end
    group_volume_changes(changed_indexes)
  end

  def group_volume_changes(changed_indexes)
    result = []
    grouped_indexes = changed_indexes.slice_when{|prev, curr| curr != prev.next}.to_a
    grouped_indexes.each do |group|
      result << {
        start_item: volume_data[group.first - 1],
        end_item: volume_data[group.last]
      }
    end
    result
  end

  def time_diff_in_mins(start_time, end_time)
    (Time.parse(start_time) - Time.parse(end_time))/60
  end
end