# frozen_string_literal: true

RSpec.describe RateDetector do
  let(:example_1_data) do
    [
      ['Timestamp', 'Volume'],
      ["2019-04-29 10:03:00", 9100],
      ["2019-04-29 10:04:00", 9400],
      ["2019-04-29 10:10:00", 9700]
    ]
  end

  let(:example_2_data) do
    [
      ['Timestamp', 'Volume'],
      ["2019-04-29 10:03:00", 9100],
      ["2019-04-29 10:04:00", 9400],
      ["2019-04-29 10:10:00", 10600]
    ]
  end


  let(:example_3_data) do
    [
      ['Timestamp', 'Volume'],
      ["2019-04-29 10:00:00", 9000],
      ["2019-04-29 10:01:00", 9010],
      ["2019-04-29 10:01:30", 9040],
      ["2019-04-29 10:02:00", 9000],
      ["2019-04-29 10:03:20", 9100],
      ["2019-04-29 10:04:00", 9400],
      ["2019-04-29 10:10:00", 11200],
      ["2019-04-29 10:10:20", 11200],
      ["2019-04-29 10:11:00", 12000],
      ["2019-04-29 10:12:00", 11000],
      ["2019-04-29 10:13:00", 12000],
      ["2019-04-29 10:14:00", 11000],
      ["2019-04-29 10:15:00", 11010],
      ["2019-04-29 10:16:00", 11020],
      ["2019-04-29 10:17:00", 9870],
      ["2019-04-29 10:18:30", 8025],
      ["2019-04-29 10:19:00", 7000]
    ]
  end

  let(:example_1_csv) do
    generate_temp_csv_file(example_1_data)
  end

  let(:example_2_csv) do
    generate_temp_csv_file(example_2_data)
  end

  let(:example_3_csv) do
    generate_temp_csv_file(example_3_data)
  end

  describe "#detect_changes" do
    it "should only pick the records that matches desired rate of change" do
      changes = described_class.new(example_1_csv, 100).detect_changes
      expect(changes.count).to eq(1)
      expect(changes.first).to eq({start_item: {timestamp: "2019-04-29 10:03:00", volume: "9100"}, end_item: {timestamp: "2019-04-29 10:04:00", volume: "9400"}})
    end

    it "should merge consecutive groups of entries that meet the rate of change criteria," do
      changes = described_class.new(example_2_csv, 100).detect_changes
      expect(changes.count).to eq(1)
      expect(changes.first).to eq({start_item: {timestamp: "2019-04-29 10:03:00", volume: "9100"}, end_item: {timestamp: "2019-04-29 10:10:00", volume: "10600"}})
    end

    it "should collect data for variety of combination" do
      changes = described_class.new(example_3_csv, 100).detect_changes
      expect(changes.count).to eq(3)
      expect(changes.first).to eq({start_item: {timestamp: "2019-04-29 10:03:20", volume: "9100"}, end_item: {timestamp: "2019-04-29 10:10:00", volume: "11200"}})
      expect(changes[1]).to eq({start_item: {timestamp: "2019-04-29 10:10:20", volume: "11200"}, end_item: {timestamp: "2019-04-29 10:14:00", volume: "11000"}})
      expect(changes[2]).to eq({start_item: {timestamp: "2019-04-29 10:16:00", volume: "11020"}, end_item: {timestamp: "2019-04-29 10:19:00", volume: "7000"}})
    end
  end
end
