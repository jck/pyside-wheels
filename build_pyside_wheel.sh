#!/usr/bin/env bash

wget https://pypi.python.org/packages/source/P/PySide/PySide-1.2.4.tar.gz
cd PySide-1.2.4

if [[ "TRAVIS_OS_NAME" == "osx" ]]; then
  brew update
  brew tap cartr/qt4
  brew tap-pin cartr/qt4
  brew install qt@4 shiboken@1.2
  python setup.py bdist_wheel
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  sudo apt-get install build-essential git cmake libqt4-dev libphonon-dev python2.7-dev libxml2-dev libxslt1-dev qtmobility-dev libqtwebkit-dev
  python2.7 setup.py bdist_wheel --qmake=/usr/bin/qmake-qt4 --standalone
fi
