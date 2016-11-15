type=$1;
name=$2;
echo $name
cp ./baseconfs/vars ./config/vars
chmod +x ./config/vars
echo "export KEY_CN=server-$name" >> config/vars
echo "export KEY_EMAIL=$email" >> config/vars 
cp ./baseconfs/vars ./config/clientvars
chmod +x ./config/vars
echo "export KEY_CN=client-$name" >> config/clientvars
echo "export KEY_EMAIL=$email" >> config/clientvars 
