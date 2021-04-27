#!/bin/bash
set -e

version=3.18
build=1

if [[ `cmake --version | grep $version.$build` ]]; then
  echo "Correct cmake version $version:$build found."
  exit 0
fi

echo "Target cmake version not found. Installing.."
sudo apt remove --purge --auto-remove cmake -y || true
mkdir ~/temp
cd ~/temp
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
tar -xzvf cmake-$version.$build.tar.gz
cd cmake-$version.$build/
./bootstrap
make
sudo make install

rm -rf ~/temp


