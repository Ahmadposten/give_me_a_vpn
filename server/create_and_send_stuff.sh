zip -r config.zip newconfig 
response=$(curl -F "config=@../config.zip" http://givemeavpn.com/storeconfig)
rm ../config.zip
echo "Your url is $response";
