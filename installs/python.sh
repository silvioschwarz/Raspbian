#! /bin/sh

sudo apt install curl
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

python3 get-pip.py

sudo apt install python-dev python-pandas python-numpy python-scipy python-matplotlib
python3 -m pip install --user dash dash-html-components dash-core-components dash-table plotly dash-daq

