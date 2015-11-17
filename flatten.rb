# Converts a CSV in which rows have the form
#   <id>,<field>,<subfield>,<value>
# into a CSV of the standard form, with header
#   id,field1.subfield1,field2.subfield2,...
# and rows
#   <id>,<value1>,<value2>,...

require 'csv'

unless ARGV.length == 1
  abort "Usage: ruby #{__FILE__} inputfile"
end

data = {}
columns = ['id']

CSV.foreach(ARGV[0], headers: false) do |row|
  id = row[0].to_i
  field = row[1]
  if row[2] and !row[2].empty?
    field += '.' + row[2]
  end
  value = row[3]
  unless columns.include?(field)
    columns.push(field)
  end
  unless data[id]
    data[id] = {}
  end
  if data[id][field]
    data[id][field] += '||' + value
  else
    data[id][field] = value
  end
end

puts columns.to_csv
data.keys.sort.each do |id|
  row = [id]
  columns[1..-1].each do |field|
    row.push(data[id][field])
  end
  puts row.to_csv
end
