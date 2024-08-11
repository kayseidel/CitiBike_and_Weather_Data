# go through each CitiBike data file and print the date from each line

BEGIN {
    FS = "|"  # fields are separated by pipes

    # command is a regex that matches every CitiBike file
    cmd = "zcat ./2014-[0-9][0-9]-CitiBiketripdata.gz"

    # for each line in the file, print the field with the date
    while((cmd | getline) > 0) {
	print $2
    }
    close(cmd) # close the file
}
