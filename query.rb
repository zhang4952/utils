# A sample query file to go along with filter.rb

# Include these columns in the output
$columns = [
  "dc.creator",
  "dc.title",
  "dc.contributor.advisor",
  "dc.contributor.committeemember",
  "dc.degree.discipline",
  "dc.degree.level",
  "dc.degree.name",
  "dc.description",
  "dc.date.copyright",
  "dc.identifier.uri"
  ]

# Here the keys are names of columns for which we want to
# match one of the listed values, and the listed values need
# only be a substring of the value under consideration
$query = {
  "dc.degree.name" => [
    "Master of Science (M.S.) in Geosciences",
    "Doctor of Philosophy (Ph. D.) in Geosciences",
    "Doctor of Philosophy (Ph. D.) in Water Resources Engineering",
    "Doctor of Philosophy (Ph. D.) in Water Resources Science",
    "Master of Science (M.S.) in Water Resources Engineering",
    "Master of Science (M.S.) in Water Resource Engineering",
    "Master of Science (M.S.) in Water Resources Policy and Management",
    "Master of Science (M.S.) in Water Resources Policy & Management",
    "Master of Science (M.S.) in Water Resource Policy and Management",
    "Master of Science (M.S.) in Water Resources Science",
    "Master of Science (M.S.) in Water Resource Science",
    "Master of Science (M.S.) in Water Resource Policy and\n\nManagement",
    "Master of Science (M.S.) in Water Resources Policy and\n\nManagement",
    "Doctor of Philosophy (Ph. D.) in Geography",
    "Master of Science (M.S.) in Geography",
    "Doctor of Philosophy (Ph. D.) in Geology",
    "Master of Science (M.S.) in Geology",
    "Master of Science (MS) in Geology",
    "Master of Science (M.S.) in Marine Resource Management",
    "Master of Science (MS) in Marine Resource Management",
    "Doctor of Philosophy (Ph. D.) in Oceanography",
    "Doctor of Philosophy (Ph. D.)in Oceanography",
    "Doctor of Philosophy (Ph. D.) Oceanography",
    "Master of Science (M.S.) in Oceanography",
    "Master of Science (MS) in Oceanography",
    "Master of Arts (M.A.) in Oceanography",
    "Doctor of Philosophy (Ph. D.) in Atmospheric Sciences",
    "Master of Science (M.S.) in Atmospheric Sciences",
    "Master of Science (M.S.) in Atmospheric Science",
    "Master of Science (MS) in Atmospheric Sciences",
    "Doctor of Philosophy (Ph. D.) in Ocean, Earth, and Atmospheric Sciences",
    "Doctor of Philosophy (Ph. D.) in Ocean, Earth, and Atmospheric Science",
    "Master of Science (M.S.) in Ocean, Earth, and Atmospheric Sciences",
    "Master of Science (M.S.) in Ocean, Earth and Atmospheric Sciences",
    "Master of Science (M.S.) in Ocean, Earth, and Atmospheric Science"
    ]
  }

# For each column name, look in column names formed by
# adding these suffixes, and in the ouput, if there are
# multiple versions of a column with non-empty values,
# append them with || as separator
$suffixes = [
  "",
  "[en]",
  "[en_US]",
  "[en_us]",
  "[]",
  "[*]"
  ]
