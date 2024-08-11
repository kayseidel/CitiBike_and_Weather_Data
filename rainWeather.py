# print to a new file the date and min and max temperature, and instead of amount of rainfall, print a new field of "yes" if there is rain or "no" if there is no rainfall. If the weather description is "light rain," consider that not significant enought to affect bike riding and label rain as "no"

# read a line at a time as input
line = input()

# while there a line
while line:
    fields = line.split("|")   # split fields on the pipes
    
    rain = "no"                # default for rain is "no"
    # if there is rain and the weather description is not 'light rain', set rain to "yes"
    if (fields[3] or fields[4]) and fields[5] != "light rain":
        rain = "yes"

    # separating fields with a pipe, print the date and temperature fields, and then whether or not there was substantial rainfall
    print(fields[0][:13], fields[1], fields[2], rain, sep="|")

    try: line = input() # try to get the next line of input
    except: line = None # if there is no line, we're done
