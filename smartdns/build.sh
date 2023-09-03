version=$1
if [ -z $version ];then
    echo "Please enter version. example $0 0.0.1"
    exit 1
fi

docker build -t smartdns:$version .
docker build -t smartdns .
