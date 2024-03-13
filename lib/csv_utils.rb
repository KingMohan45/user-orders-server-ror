# frozen_string_literal: true
require 'active_record'
require 'csv'

module CsvUtils
  def self.read_csv(filename)
    rows = []
    CSV.foreach(filename, headers: true) do |row|
      rows << row.to_hash
    end
    rows
  end

  def self.json_to_csv(json_data)
    csv_data = CSV.generate do |csv_data|
      csv_data << json_data.first.keys
      json_data.each do |order|
        csv_data << order.values
      end
    end
    csv_data
  end

  def self.create_records_from_csv(filename, model, column_map)
    rows = CsvUtils.read_csv(filename)
    rows.each do |row|
      begin
        puts "Processing row: #{row}"
        record = model.new
        column_map.each do |csvColumn, modelColumn|
          record[modelColumn] = row[csvColumn]
        end
        record.save!
      rescue ActiveRecord::RecordNotUnique => e
        puts "Record already exists! Skipping..."
      rescue StandardError => e
        puts "Error creating record: #{e.message}"
      end
    end
    puts "Created #{rows.length} records from #{filename} in the #{model} model."
  end
end
