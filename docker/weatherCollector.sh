echo $(cat /root/token.txt) >> log_run_weather.txt
echo "End start MAIN:`date`" >> log_run_weather.txt
DATA=/root/RAM
KEY=$(cat /root/token.txt)
GEOLOCATION=$(cat /root/GEOLOCATION.txt)

# Get Weather
curl http://api.openweathermap.org/data/2.5/weather?${GEOLOCATION}\&units=metric\&APPID=$KEY > $DATA/weather.json
# Parse Weather
jq -r " [.coord.lon, .coord.lat, .weather[0].id, .weather[0].main, .main.humidity , .main.temp, .name, .dt, .id] | @csv" < $DATA/weather.json > $DATA/weather.csv

# Save Weather
cqlsh cassandra_host --execute="copy Weather.currentWeather(lon,lat,idWeather,mainWeather,humidityMetric,temperatureMetric,nameStation,epochCollected,idStation) from '$DATA/weather.csv ' WITH DELIMITER =',' AND HEADER=FALSE ";

echo "End run MAIN:`date`" >> log_run_weather.txt
