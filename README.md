
# Geoffrey Project


## Interpretation of Task

Here is the orginal task statement

> Your task is to provide a method that accepts a date and computes
> the mean and median temperature for Canadian's daytime temperature
> that urban Canadian's experienced on that day. 

On a given date, every member of the urban population observes a local_temperature.
Every member of the urban population belongs to a given city (as defined by cities.csv)
For every member of the urban population the local_temperature on a given date will be assumed to be the mean_temperature of the closest station that reports a mean_temperature on that date.

To determine the entire urban population we will use the population-per-city reported in cities.csv (not the population_proper).

The do_me script will calculate the urban-population-mean-temp, and the
urban-population-median-temp as defined as follows

* urban-population-mean-temp
  * The mean from the task is the mean local_temperature over the entire urban population

* urban-population-median-temp
  * The median from the task is the median local_temperature over the entire urban population.


## Missing Temperature Observations

For our task, the key data to extract from climate.csv is the mean_temperature for a station on a given date.
However, mean_temperature at a given station on a given date is not always available.

The file climate.csv does NOT contain a row for every possible date for every station. 
For some stations, there are some dates that are not reported in climate.csv.
On these dates, we do not know what the mean_temperature was for the station.

In addition, even when climate.csv contains a row for a given station and date, that row may report a null temperature, or a temperature with a M flag indicating that the temperature was not reported for that station on the given date.
Again, on these dates, we do not know what the mean_temperature was for the station.


## Size of Data

For order of complexity estimates, the following data size variables will be used.

* num stations  S = 958
* num dates  D = 47
* max station/date rows  S * D = 45026
* num climate.csv rows  41513
* num cities  C = 247



## Strategy

Here is a rough outline of the strategy used to compute the urban population mean and median temperatur.

* pre-process to find closest station to each city, regardless of date  O(S * C)
  * find per-station lat/lng from climate.csv
  * find per-city lat/lng from cities.csv
  * (this only needs to be done once)

* then for a given date
  * extract station lat/lng and temp available on the given date  O(S * D)
  * incrementally find best station (per-city) available on date  
    * start with pre-processed closest station (regardless of date)
    * find stations not available on given date  O(S * log(S))
    * find cities with closest stations not available on given date  O( C)
      * num cities with unavailable closest = U  (U < C)
    * recalculate closest station available on date for these cities  O(S * U)

  * for each city, get temp from closest station  O(S + C)
  * calculate mean and median temp over entire urban population  O(C * log( C))

This strategy is implemented using bash script and awk.
The awk scripts use associative arrays, and for complexity I assume that indexing into the arrays is O(N) where N is the number of entries in the array.


## Optimizing Calculation of Closest

The most computationaly intensive part of the strategy is finding for each city,
the closest station with temp data available on the given day.

In a pre-procssing phase the closest station regardless of date is found.
This involves finding the distance between each city and every station.
This distance information is recorded for future use.

To find the closest station on a given date, the scripts first find which stations are missing temp data on the given date.
Next the scripts find which cities have pre-processed closest stations that are missing.
The scripts then re-calculate the closest stations for these cities from the available recorded distance information.

Future work to reduce the effort to find the closest station to a city
could consider dividing the cities into different bins by lat
to reduce the number of stations that need to be considered for each bin to find the closest station.

#### Definition of Distance

The current scripts use Manhattan distance to calculate the distance
between a city and a station. This is cheap-n-cheerful, but wildly inaccurate.
The are many other possible distance calculations (in order of complexity and accuracy)

* manhattan distance
* euclidean distance (flat earth)
* haversine distance (sphere)
* ellipsoid distance


## Where to find things

Here is where to find things within the directory structure for GeoffreyProject

* GeoffreyProject
  * Scripts
    * calc_given_date
      * calculate urban population mean/median on given date
    * run_ref
      * run refence calc_given_date for 2020-01-01
  * RefOutput
    * reference output from running ./Scripts/run_ref
    * the output can be found in log_ref.txt

Note, the scripts use hardcoded paths to other scripts, and 
assume that scripts are run from the GeoffreyProject directory.

## How to run the scripts

The top-level script is calc_given_date.

The usage for calc_given_date is

* ./Scripts/calc_given_date < date>

where date is of the form 2020-01-01.
(this is the format of the LOCAL_DATE column in climate.csv with the 00:00:00 time stripped)

## Sample output
Here is the sample log_ref.txt output from Scripts/run_ref

    Calculate urban population mean/median temp observed on date 2020-01-01
    
    did not find best_station.txt, run pre-processing
    Pre-process climate/city data independent of date
    
    num stations  S = 958
    num dates  D = 47
    max station/date rows  S * D = 45026
    num climate.csv rows  41513
    num cities  C = 247
    
    extract city lat/lng  O(C)
    extract station lat/lng   O(S*D)
    
    find closest station for each city, regardless of date  O(S*C)
    
    extract climate data available on date  O(S*D)
    extract station lat/lng and temp available on date  O(S)
    
    incrementally find best station (per-city) available on date
    start with pre-processed closest station regardless of date
    find stations not available on given date  O(S*log(S))
    find cities with closest stations not available on given date  O(C)
    num cities with unavailable closest  U = 18,  (U < C)
    recalculate closest station available on date for these cities  O(S*U)
    
    for each city, get temp from closest station  O(S+C)
    calculate mean and median temp over entire urban population  O(C*log(C))
    poptotal 23133597
    mean 0.367022
    pophalf = 1.15668e+07
    poprun 14486068 median -0.1


