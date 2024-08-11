# reformat citiBike data so that all dates are in year-mm-dd format

BEGIN {
    FS = "|"
    OFS = "|"
    
    cmd = " zcat ./2014-[0-9][0-9]-CitiBiketripdata.gz"

    while((cmd | getline) > 0) {
	if ($2 ~ "^[0-9][0-9]?/[0-9][0-9]?/2014")
	    
	
    }
    close(file)
}
