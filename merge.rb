# Merges two CSVs using first column as primary key (id).
# Assumes columns are unique to each input CSV.

require "csv"

# Merged data as a hash of hashes.
# Keys are ids, values are hashes of values keyed on column names.
merged = {}

# Header label for primary key.
# Eventually becomes the header used in the last input file.
idlabel = nil

# List of all column names, in the same order as the input files.
merged_cols = []

ARGV.each do |arg|

  # Read in CSV and pull out headers.
  table = CSV.read arg
  idlabel = table[0].shift
  columns = table.shift

  table.each do |row|

    # Pull out id and create its hash if it hasn't been seen yet.
    id = row.shift
    if merged[id].nil?
      merged[id] = {}
    end

    # Pull out data values.
    for i in 0..row.length - 1
      merged[id][columns[i]] = row[i]
    end
  end

  # Save column headers.
  merged_cols += columns
end

# Output merged data as CSV.
headers = [idlabel] + merged_cols
puts headers.to_csv
merged.each do |id, valuehash|
  row = [id]
  merged_cols.each do |col|
    value = valuehash[col]
    if value.nil?
      row << nil
    else
      row << value
    end
  end
  puts row.to_csv
end
