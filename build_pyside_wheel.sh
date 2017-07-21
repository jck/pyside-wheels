#!/usr/bin/env bash

wget https://pypi.python.org/packages/source/P/PySide/PySide-1.2.4.tar.gz
tar -xvzf PySide-1.2.4.tar.gz
cd PySide-1.2.4

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update
  brew tap cartr/qt4
  brew tap-pin cartr/qt4
  brew install qt@4 shiboken@1.2
  python setup.py bdist_wheel
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
  sudo apt-get install build-essential git cmake libqt4-dev libphonon-dev python2.7-dev libxml2-dev libxslt1-dev qtmobility-dev libqtwebkit-dev
  python2.7 setup.py bdist_wheel --qmake=/usr/bin/qmake-qt4 --standalone
fi

cp dist/* $HOME/wheelhouse/


transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi 
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 

transfer $HOME/wheelhouse/*
