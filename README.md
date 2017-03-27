# openweatherCassandraClient
Sample cassandra client of consuming weather data for a city


# Running Image

This sample uses 2 containers to run the sample.
- 1st is `sample_cassandra` that is simple Cassandra DB
- 2nd is `cassandra_weather_app` that is the weather collector app.

The separation is meant to allow better separation of code and to allow the cassandra(`cassandra_host`) to be shared by multiple apps.

```
git clone https://github.com/i40poster/openweatherCassandraClient.git
cd openweatherCassandraClient
docker build  -t cassandra_weather_app ./docker/

docker run --name sample_cassandra -d cassandra:3.10
#sleep is used to allow cassandra to start properly
sleep 30

#optional in case there were a previous version runnning
docker stop sample_cassandra_weather_app
#optional in case there were a previous version runnning
docker rm sample_cassandra_weather_app


#running the image
docker run --name sample_cassandra_weather_app --link sample_cassandra:cassandra_host  --tmpfs /root/RAM:size=32M -e API_OPENWEATHER_KEY="API_KEY_GET_FROM_OPEN_WEATHER_SITE"  -e GEOLOCATION="lat=-23.5485&lon=-46.658" -d  cassandra_weather_app
```

- `API_OPENWEATHER_KEY`: Your open weather API key, to get one access <https://openweathermap.org>.
- `GEOLOCATION`: Location of the sensor you want to collect.
  - London: `lat=51.500&lon=-0.126`
  - Sao Paulo: `lat=-23.5485&lon=-46.658`

# Running from DockerHub
