#!/bin/bash
cqlsh cassandra_host < /root/weather.cql
echo "${API_OPENWEATHER_KEY}" > /root/token.txt
echo "${GEOLOCATION}" > /root/GEOLOCATION.txt

/root/weatherCollector.sh
