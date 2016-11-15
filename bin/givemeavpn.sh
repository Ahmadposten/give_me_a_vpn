name="Nobody";
type="";
url="";
while [ "$1" != "" ]; do
    case $1 in
        -t | --type )           shift 
                                type=$1
                                ;;
        -n | --name   )         shift
                                name=$1
                                ;;
        -e | --email )          shift
                                email=$1 
                                ;;
        -s | --server )         
                                type="server"
                                ;;
        -u | --url )            shift
                                url=$1
                                ;;
        -h | --help )           
                                exit
                                ;;
        * )                     #usage
                                exit 1
    esac
    shift
done


if [ -d ./config ]; then
    rm -rf config;
    mkdir config;
else
    mkdir config;
fi

if [ "$type" = "server" ]; then 
    sh bin/generatevars.sh server $name
    sh bin/generateconf.sh server;
    cp bin/create_and_send_stuff.sh server;
    cp -r config server
    cd server;
    docker build -t givemeavpn-server .;
else
    echo "$name"
    sh ./generatevars.sh client $name;
    sh ./generateconf.sh client;
    cd client;
    docker build -t givemeavpn-client .;
fi
