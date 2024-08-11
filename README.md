# CitiBike_and_Weather_Data

Hypothesis: In nicer weather, individuals in Manhattan are more likely to rent CitiBikes.

Data Sources:
- CitiBike System Data- Data containing information of all CitiBike rides in 2014 (https://citibikenyc.com/system-data)
- Manhattan Historical Weather Data- Data containing hourly information about the weather in Manhattan going back to 1979

Procedure:
- First, I used an awk program to filter down the Manhattan weather dataset to get just the fields of the date and time,
  the minimum temperature for that time, the maximum temperature for that time, the rainfall over a 1-hour period, the
  rainfall over a 3-hour period, and the description of the weather. I then used another awk program to filter the data
  down again to only use the data from 2014, since that is where the CitiBike data is from.  Next, if any weather record
  that had an amount of rainfall, whether it was over a 1-hour period or 3-hour period (since often it had one or the other),
  and the weather was not described as “light rain,” I used a python program to print to a new file each record with a “yes”
  if there was substantial rainfall at all and a “no” if there was no rainfall at all or if it was just “light rain.” Since
  the original weather data produces a new record of weather for every hour, I then used an awk program to create time-chunks
  for the weather data, so that I would be able to look at the weather over 4-hour periods at a time. Finally, I used a Spark
  program to find and print the average of the minimum and maximum temperature for each time-chunk of each day of the year.
  Then I took the CitiBike datasets, which were each distinct files for each month of the year, and used an awk script to
  combine the separate files into one big CitiBike data file. Since the date field for the CitiBike data was not formatted
  the same for each file (some were m/d/year and some were year-mm-dd, I used a python script to make sure they would all be
  formatted the same, in the year-mm-dd format. Next, I used an awk program to create time-chunks for the bike data, so that
  I would be able to look at the CitiBike records over 4-hour periods at a time. I then used a spark program to create a new
  file with the date, time chunk, and the number of CitiBikes ridden during each time-chunk. After that, I used a spark program
  to combine the final weather file with the final CitiBike file into one file with lines that have the date, the time-chunk,
  the average weather during that time, if there was rain, and the number of CitiBikes ridden during that time. Lastly, I used
  Matplotlib to create a scatter plot of my results, with the average temperature as the x-axis and the number of CitiBikes
  ridden as the y-axis. If there was rain recorded for that time, the point is red; otherwise it is blue.
Conclusion:
- The results from my plot show that there is a positive correlation between weather temperature and CitiBike rides, since as
  the temperature rises, so do the number of bike rides. However, most of the points on the plot occur around or below 2000
  bike rides, indicating that regardless of the weather, there are still people riding CitiBikes, albeit a smaller number of
  people. Similarly, there seem to be less bikes ridden while it is raining, yet there are still a number of bikes being ridden
  even while there is rainfall. I believe these results adequately prove that more people are likely to rent CitiBikes in nicer
  weather, and they also show that CitiBike riding is consistent and there are always people renting bikes, regardless of the weather.
