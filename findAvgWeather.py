# combine and return the average weather for each day of the year of 2014

import pyspark

sc = pyspark.SparkContext()
sc.setLogLevel("ERROR")

# input: weather data from 2014, with date, timeChunk, min and max temps, rainfall
# returns: a tuple contatining a tuple of the date and chunk, and rain as the key and as the data, a tuple of the min weather as the key and max weather
# ((month:day, chunk), (min, max))
def dateMinMaxWeather(x):
    fields = x.split("|")
    key = ((fields[0][:10], fields[1]), fields[4])
    data = (float(fields[2]), float(fields[3]))

    return key, data

a = sc.textFile("./chunkedWeather") # lines from chunked weather file
b = a.map(dateMinMaxWeather)        # (((month:day, chunk), rain), (min, max))
c = b.reduceByKey(lambda x,y: ((x[0]+y[0]) / 2, (x[1]+y[1]) / 2)) # ((date, rain), (avgMins, avgMaxs))
d = c.map(lambda x: (x[0][0][0], x[0][0][1], round(((x[1][0] + x[1][1]) / 2), 2), x[0][1]))  # (date, chunk, avgWeather, rain)
e = d.collect() # get all tuples and put them into a list

for i in e:            # for each tuple in the list:
    print(*i, sep="|") # print all tuples as pipe delimited elements
