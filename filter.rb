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

CSV.open(output, "w") do |out|
  out << $columns
  CSV.foreach(input, headers: true) do |row|
    includerow = true
    for key in $query.keys
      satisfies = false
      for suffix in $suffixes
        if !row[key + suffix].nil? && $query[key].include?(row[key + suffix])
          satisfies = true
        end
      end
      if !satisfies
        includerow = false
      end
    end
    if includerow
      values = []
      found = nil
      for column in $columns
        for suffix in $suffixes
          if !row[column + suffix].nil?
            found = row[column + suffix]
            break
          end
        end
        values << found
      end
      out << values
    end
  end
end
