require_relative 'lib/rate_detector'
require_relative 'lib/csv_data_formatter'
require 'byebug'

rate_detector = RateDetector.new(ARGV[0], ARGV[1])
changes = rate_detector.detect_changes

puts %(Start Timestamp, End Timestamp, Start Volume, End Volume)
changes.each do |change_data|
  puts change_data[:start_item][:timestamp] + ', ' + change_data[:end_item][:timestamp] + ', ' + change_data[:start_item][:volume].to_s + ', ' + change_data[:end_item][:volume].to_s
end

