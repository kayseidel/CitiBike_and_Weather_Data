# plot the data on a scatter plot, with the average weather as the x-axis and the number of bike rides as the y-axis

import matplotlib.pyplot as plt
import sys

f = plt.figure()

x = []  # create list to be added to for x-axis
y = []  # create list to be added to for y-axis
colors = [] # create list for colors

# for each line in the input file
for line in sys.stdin:
    fields = line.strip().split("|") # split fields by the pipe
    x.append(float(fields[2]))       # add to x-axis list items from field 2 (avgWeather) 
    y.append(int(fields[4]))         # add to y-axis list items from field 4 (# bikes ridden)

    # if field 3 == "yes", there is rain during this time chunk-- this dot on plot will be red
    if fields[3] == 'yes':
        colors.append('red')
    # otherwise, no rain-- this dot will be blue
    else:
        colors.append('blue')

# plot scatter plot of x-axis list, y-axis list, colors, and make the transparency 0.25
plt.scatter(x, y, c=colors, alpha=0.25)

plt.xlabel("Average Temperature in Fahrenheit") # label x-axis
plt.ylabel("Number of CitiBikes Ridden")        # label y-axis

f.savefig("weatherAndBikes.pdf") # save plot as pdf
