#! /bin/bash
set -e

if [ ! -f ./schemaspy.jar ]; then
  curl -L 'https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar' \
    -o ./schemaspy.jar
fi

if [ ! -f ./mysql-connector-java-5.1.47.jar ]; then
  curl 'http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.47/mysql-connector-java-5.1.47.jar' \
    -o ./mysql-connector-java-5.1.47.jar
fi

if [ -d ./schemaspy ]; then
  rm -fR ./schemaspy
fi

java -jar ./schemaspy.jar \
  -t mysql \
  -host 127.0.0.1 \
  -port 3306 \
  -db matomo \
  -s matomo \
  -u matomo \
  -p matomo \
  -o ./schemaspy \
  -dp ./mysql-connector-java-5.1.47.jar \
  -connprops useSSL\\=false
