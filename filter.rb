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

require_relative query

CSV.open(output, "w") do |out|
  out << $columns
  CSV.foreach(input, headers: true) do |row|
    includerow = true
    for column in $query.keys
      satisfies = false
      for suffix in $suffixes
        unless row[column + suffix].nil?
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
      end
    end
    if includerow
      values = []
      for column in $columns
      	found = nil
        for suffix in $suffixes
          unless row[column + suffix].nil? || row[column + suffix].empty?
            if !found
              found = row[column + suffix]
            else
              found += "||" + row[column + suffix]
            end
          end
        end
        values << found
      end
      out << values
    end
  end
end
