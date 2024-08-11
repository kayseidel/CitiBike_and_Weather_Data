# add up the number of bikes ridden for each time chunk on each day and print lines containing the date of the ride, with the 4-hour chunk, and the number of CitiBikes ridden during that chunk of time
# date | chunk | numRides

import pyspark

sc = pyspark.SparkContext()
sc.setLogLevel("ERROR")

file = "./chunkedBikes" # input from chunked bikes file

# input: lines from chunked bikes file
# return: ((date, chunk), 1)
def dateChunkOne(x):
    fields = x.split("|")
    return ((fields[0][:10], fields[1]), 1)

a = sc.textFile(file) # citiBike data
b = a.map(dateChunkOne) # ((date, chunk), 1)
c = b.reduceByKey(lambda x,y: x+y) # ((date, chunk), total rides during that time)
d = c.map(lambda x: (x[0][0], x[0][1], x[1])) # (date, chunk, total)
e = d.collect() # get all tuples and put them into a list

for i in e:            # for each tuple in the list:
    print(*i, sep="|") # print all tuples as pipe-delimited elements
