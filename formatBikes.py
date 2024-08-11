# reformat some of the dates in the file so that they all are in the format of year-mm-dd (some of them are m/d/year)

line = input() # read a line at a time as input
while line:
    dateTime = line
    
    # if the date is in dashed format (year-mm-dd), its good- just print the line
    if "-" in dateTime:
        print(dateTime)

    # otherwise, we need to get it into the correct format
    else:
        date = dateTime.split(" ")     # split line on white space to separate date and time
        dateParts = date[0].split("/") # split on forward slashes to get each part of date
        month = dateParts[0] # this is the month
        day = dateParts[1]   # this is the day
        year = dateParts[2]  # this is the year

        # if there is only one number for the month, add a zero to start
        if len(month) == 1:
            month = "0" + month

        # if there is only one number for the day, add a zero to start
        if len(day) == 1:
            day = "0" + day

        # print out reformatted date
        newDate = year + "-" + month + "-" + day + " " + date[1]
        print(newDate)

    try: line = input() # try to get the next line of input
    except: line = None # if there is no line, we're done
