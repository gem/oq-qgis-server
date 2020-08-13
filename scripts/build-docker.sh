#!/usr/bin/env bash

set -e 

RELEASE_TYPE=$1
QGIS_VERSION=$2
UBUNTU_DIST=$3

MAJOR_QGIS_VERSION=$(echo "${QGIS_VERSION}" | cut -d. -f1,2)

if [[ ${RELEASE_TYPE} =~ ^ltr$ ]]; then
  QGIS_UBUNTU_PPA='ubuntu-ltr'
else
  QGIS_UBUNTU_PPA='ubuntu'
fi

echo "Building QGIS Server Docker image:"
echo "RELEASE_TYPE: ${RELEASE_TYPE}"
echo "QGIS_VERSION: ${QGIS_VERSION}"
echo "MAJOR_QGIS_VERSION: ${MAJOR_QGIS_VERSION}"
echo "UBUNTU_DIST: ${UBUNTU_DIST}"
echo "QGIS_UBUNTU_PPA: ${QGIS_UBUNTU_PPA}"

docker build --build-arg repo=${QGIS_UBUNTU_PPA} -t openquake/qgis-server:${RELEASE_TYPE}-ubuntu -f Dockerfile.ubuntu .

docker tag openquake/qgis-server:${RELEASE_TYPE}-ubuntu openquake/qgis-server:${MAJOR_QGIS_VERSION}-ubuntu
docker tag openquake/qgis-server:${RELEASE_TYPE}-ubuntu openquake/qgis-server:${QGIS_VERSION-ubuntu

docker push openquake/qgis-server:${RELEASE_TYPE}-ubuntu
docker push openquake/qgis-server:${MAJOR_QGIS_VERSION}-ubuntu
docker push openquake/qgis-server:${QGIS_VERSION-ubuntu