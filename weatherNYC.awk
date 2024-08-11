# print the lines of the manhattan weather file to a new file, filtering to get the date, min temperature, max temperature, rain volume over the past hour and three hours, and weather description

BEGIN {
    # input and output should be pipe-delimited
    FS = "|"
    OFS = "|"

    # for each line of the Manhattan weather file, print the date, min-temp, max-temp, rain (1h & 3h) volume, and weather description columns to a new file
    cmd = "zcat ./manhattanWeatherClean.gz"
    while ((cmd | getline) > 0) {
	print $2, $11, $12, $20, $21, $27 > "filteredWeather"
    }
    close(cmd) # close input file
}
