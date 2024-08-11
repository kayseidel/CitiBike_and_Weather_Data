# make 4-hour chunks for bike times throughout the day:
# 12:00AM-3:00AM, 4:00AM-7:00AM, 8:00AM-11:00AM, 12:00PM-3:00PM, 4:00PM-7:00PM, and 8:00PM-11:00PM
# add the chunks as a new field next to the date
# print: date | timeChunk

BEGIN {
    FS = "|"  # input field separator
    OFS = "|" # output field separator
    file = "./citiBikeClean" # input file

    # while there is a line in the file, read in the line
    while((getline < file) > 0) {
	# if the time in the field is 00, 01, 02, or 03, it's chunk is from 12:00AM-3:59AM, so the chunk as a new field
	if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} 0[0-3]/)
	    print $1, "12:00AM-3:59AM"
	# if the time in the field is 04, 05, 06, or 07, it's chunk is from 4:00AM-7:59AM
	else if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} 0[4-7]/)
	    print $1, "4:00AM-7:59AM"
	# if the time in the field is 08, 09, 10, or 11, it's chunk is from 8:00AM-11:59AM
	else if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} (08|09|10|11)/)
	    print $1, "8:00AM-11:59AM"
	# if the time in the field is 12, 13, 14, or 15, it's chunk is from 12:00PM-3:59PM
	else if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} 1[2-5]/)
	    print $1, "12:00PM-3:59PM"
	# if the time in the field is 04, 05, 06, or 07, it's chunk is from 4:00PM-7:59PM
	else if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} 1[6-9]/)
	    print $1, "4:00PM-7:59PM"
	# if the time in the field is 04, 05, 06, or 07, it's chunk is from 8:00PM-11:59PM
	else if ($1 ~ /[0-9]{4}-[0-9]{2}-[0-9]{2} 2[0-3]/)
	    print $1, "8:00PM-11:59PM"
    }
    close(file) # close the file
}
