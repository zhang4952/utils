# Filters a CSV, including only the specified columns
# and only rows that match the query. The query gives
# the list of desired values under a given column (key).
# Usage: ruby filter.rb inputfile outputfile

require "csv"

input = ARGV[0]
output = ARGV[1]

columns = [
  "dc.creator",
  "dc.title",
  "dc.contributor.advisor",
  "dc.contributor.committeemember",
  "dc.degree.discipline",
  "dc.degree.level",
  "dc.degree.name",
  "dc.description",
  "dc.date.copyright",
  "dc.identifier.uri",
  ]

suffixes = [
  "",
  "[]",
  "[en]",
  "[en_US]",
  "[en_us]",
  "[*]"
  ]

query = {
  "dc.degree.name" => [
    "Doctor of Philosophy (Ph. D.) in Water Resources Engineering",
    "Master of Science (M.S.) in Water Resources Engineering",
    "Master of Science (M.S.) in Water Resource Engineering",
    "Master of Science (M.S.) in Water Resources Policy and Management",
    "Master of Science (M.S.) in Water Resources Science",
    "Doctor of Philosophy (Ph. D.) in Geography",
    "Master of Science (M.S.) in Geography",
    "Doctor of Philosophy (Ph. D.) in Geology",
    "Master of Science (M.S.) in Geology",
    "Master of Science (M.S.) in Marine Resource Management",
    "Doctor of Philosophy (Ph. D.) in Oceanography",
    "Master of Science (M.S.) in Oceanography",
    "Doctor of Philosophy (Ph. D.) in Atmospheric Sciences",
    "Master of Science (M.S.) in Atmospheric Sciences",
    "Doctor of Philosophy (Ph. D.) in Ocean, Earth, and Atmospheric Sciences",
    "Master of Science (M.S.) in Ocean, Earth, and Atmospheric Sciences"
    ]
  }

CSV.open(output, "w") do |out|
  out << columns
  CSV.foreach(input, headers: true) do |row|
    includerow = true
    for key in query.keys
      satisfies = false
      for suffix in suffixes
        if !row[key + suffix].nil? && query[key].include?(row[key + suffix])
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
      for column in columns
        for suffix in suffixes
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
