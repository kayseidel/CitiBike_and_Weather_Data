# run entire process
all: weatherAndBikes.pdf

# remove all files created by running processes
clean:
	rm filteredWeather weather2014 weather2014rain chunkedWeather avgWeathers citiBikeData citiBikeClean chunkedBikes rideAmounts weatherAndBikes weatherAndBikes.pdf

# use a scatterplot to plot the average temperature against the number of bike rides, and make rainy days plotted as red dots
weatherAndBikes.pdf: weatherAndBikes doPlot.py
	python3 doPlot.py <weatherAndBikes

# combine data from weather file and CitiBike file to get one merged file
# date 2014 | timeChunk | avgTemp | rain | numBikes
weatherAndBikes: combineWeatherBikes.py avgWeathers rideAmounts
	spark-submit combineWeatherBikes.py | sort > weatherAndBikes

# for each time chunk of each day, get the number of CitiBikes ridden during that time
# date 2014 | timeChunk | numBikes
rideAmounts: chunkedBikes citiBikeRides.py
	spark-submit citiBikeRides.py | sort | egrep "^[0-9]{2}" > rideAmounts

# put CitiBike data into 4-hour chunks for each day depending on the time of day
# date | timeChunk
chunkedBikes: citiBikeClean getBikeChunks.awk
	gawk -f getBikeChunks.awk > chunkedBikes

# fix the formats for CitiBike data so that all dates are in the same format
# date
citiBikeClean: citiBikeData formatBikes.py
	cat citiBikeData | python3 formatBikes.py > citiBikeClean

# combine CitiBike zip files into one file and print just the date
# date
citiBikeData: 2014-[0-9][0-9]-CitiBiketripdata.gz combineBikeData.awk
	gawk -f combineBikeData.awk | egrep "^[0-9]" > citiBikeData

# for each time chunk of each day, get the average of the min and max weather
# date 2014 | timeChunk | avgTemp | rain
avgWeathers: chunkedWeather findAvgWeather.py
	spark-submit findAvgWeather.py | sort > avgWeathers

# put weather records into 4-hour chunks for each day depending on the time of day
# date 2014 | timeChunk | minTemp | maxTemp | rain
chunkedWeather: weather2014rain getWeatherChunks.awk
	gawk -f getWeatherChunks.awk > chunkedWeather

# output whether there was significant rain or not for each record
# date 2014 | minTemp | maxTemp | rain ('yes'/'no')
weather2014rain: weather2014 rainWeather.py
	cat weather2014 | python3 rainWeather.py > weather2014rain

# filter weather data again to get only weather records from 2014
# date 2014 | minTemp | maxTemp | rainfall 1h | rainfall 3h | description
weather2014: filteredWeather findWeather2014.awk
	gawk -f findWeather2014.awk > weather2014

# filter weather data to get:
# date | minTemp | maxTemp | rainfall 1h | rainfall 3h | description
filteredWeather: manhattanWeatherClean.gz weatherNYC.awk
	gawk -f weatherNYC.awk > filteredWeather
