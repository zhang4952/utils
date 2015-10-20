# Filters a CSV, including only the specified columns
# and only rows that match the query. The query gives
# the list of desired values under a given column (key).
# Usage: ruby filter.rb queryfile inputfile outputfile

if ARGV.length != 3
  abort "Usage: ruby filter.rb queryfile inputfile outputfile"
end

require "csv"

query = ARGV[0]
input = ARGV[1]
output = ARGV[2]

require query

def include?(row)
  includerow = true
  for column in $query.keys
    satisfies = false
    for suffix in $suffixes
      unless row[column + suffix].nil? || row[column + suffix].empty?
        for desired in $query[column]
          if row[column + suffix].include?(desired)
            satisfies = true
            break
          end
        end
      end
    end
    unless satisfies
      includerow = false
      break
    end
  end
  return includerow
end

include_column = {}
for column in $columns
  include_column[column] = {}
  for suffix in $suffixes
    include_column[column][suffix] = false
  end
end

CSV.foreach(input, headers: true) do |row|
  if include?(row)
    for column in $columns
      for suffix in $suffixes
        unless row[column + suffix].nil? || row[column + suffix].empty?
          include_column[column][suffix] = true
        end
      end
    end
  end
end

all_columns = []
for column in include_column.keys
  for suffix in include_column[column].keys
    if include_column[column][suffix]
      all_columns.push(column + suffix)
    end
  end
end

CSV.open(output, "w") do |out|
  out << all_columns
  CSV.foreach(input, headers: true) do |row|
    if include?(row)
      values = []
      for column in all_columns
        values.push(row[column])
      end
      out << values
    end
  end
end
