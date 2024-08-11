# filter weather down to only include the year 2014

BEGIN {
    # output fields as pipe-delimited
    OFS = "|"

    # use the filtered weather file as the input file
    file = "./filteredWeather"

    # for each line of the file, if the date column begins with 2014, print the entire line to a new file
    while ((getline < file) > 0) {
	if ($1 ~ /^2014/)
	    print $0 > "weather2014"
    }
    close(file) # close input file
}
