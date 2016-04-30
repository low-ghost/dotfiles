cat ~/temp_weather.json | jq --compact-output --raw-output '.current_observation | "\(.temp_f)°F  \(.icon)"'
