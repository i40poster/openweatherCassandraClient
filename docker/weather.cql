CREATE KEYSPACE  IF NOT EXISTS Weather
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TABLE IF NOT EXISTS Weather.currentWeather (
      epochCollected bigint ,
      idWeather bigint,
      idStation bigint,
      nameStation varchar,
      mainWeather varchar,
      humidityMetric int,
      temperatureMetric double,
      lon double,
      lat double,
      PRIMARY KEY(idStation, epochCollected)
    ) WITH CLUSTERING ORDER BY (epochCollected DESC);

/*
Table Update:
As the data will be always queried based on a given station, ID station should  come first to allow better access time.
PRIMARY KEY(idStation, epochCollected)


It was also added "WITH CLUSTERING ORDER BY (epochCollected DESC)" to allow newest data to be in the top of the queries.

The main query to be used here would be:

Select * from Weather.currentWeather where idStation=X and epochCollected=Z (or in a range)

epochCollected => changed to bigint
*/
