# merge the weather file and the bike file to get one combined file with lines that look like this:
# date | timeChunk | avgWeather | rain | numBikeRides

import pyspark
sc = pyspark.SparkContext()
sc.setLogLevel("ERROR")

# ((date, time chunk), (avgTemp, rain))
def mergeWeather(x):
    fields = x.split("|")
    key = fields[0], fields[1]
    data = fields[2], fields[3]
    return key, data

# ((date, time chunk), # bikes)
def mergeBikes(x):
    fields = x.split("|")
    key = fields[0], fields[1]
    data = fields[2]
    return key, data

a = sc.textFile("./avgWeathers")
b = a.map(mergeWeather)   # ((date, chunk), (avgTemp, rain))

c = sc.textFile("./rideAmounts")
d = c.map(mergeBikes)     # ((date, chunk), # bikes)

e = b.join(d) # combine both tuple sets

# map to get one big tuple: (date, chunk, avgTemp, rain, numBikes)
f = e.map(lambda x: (x[0][0], x[0][1], x[1][0][0], x[1][0][1], x[1][1]))
g = f.collect()

# for each tuple, in the list, print all tuples as pipe-delimited elements
for i in g:
    print(*i, sep="|")
