
# Asymptotic iteration method for  <br> eigenvalue problems (AIM)

To read about the AIM use the following links:  
1. https://arxiv.org/abs/math-ph/0309066
2. http://iopscience.iop.org/article/10.1088/0305-4470/36/47/008/meta

### Live Jupyter notebooks on mybinder.org
Click the button below to run Jupyter notebook on mybinder and try examples given in **/examples** folder.  
[![Binder](https://mybinder.org/badge_logo.svg)](http://mybinder.org:/repo/mkarakoc/aim)

<!--- 
## Travis-ci
[![Build Status](https://travis-ci.org/mkarakoc/aim.svg?branch=master)](https://travis-ci.org/mkarakoc/aim) 
--->
## How to run the code in your local PC
You can use one of the following methods below. 

### 1.  Use the docker image
Please first read about **git** and **docker** if you have no experience.  

	~$ sudo apt install git docker
	~$ git clone https://github.com/mkarakoc/aim.git
	~$ cd aim
	~$ sudo docker build -t jupyter_docker .
	~$ sudo docker run -ti jupyter_docker
If everything successful you will see a link similar to the following:

	http://172.17.0.2:8080/?token=...

### 2. Install the libraries
**/examples** folder contains "asymptotic.py" and the example ".ipynb" files.
If the following instructions are followed, the examples will be ready to run 
in your local machine with an Ubuntu (18.04) Operating System.

#### create a folder to store the library files
	~$ mkdir /home/(user)/pylibs
	~$ cd /home/(user)/pylibs
#### download or clone: gmp, mpfr, flint2, and arb files
	~$ wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2
	~$ wget http://www.mpfr.org/mpfr-current/mpfr-4.0.2.tar.gz
	~$ git clone https://github.com/fredrik-johansson/flint2.git
	~$ git clone https://github.com/fredrik-johansson/arb.git
	~$ git clone https://github.com/fredrik-johansson/python-flint.git

#### install m4
	~$ sudo apt-get install m4

#### install gmp
	~$ tar -xvf gmp-6.1.2.tar.bz2
	~$ cd ./gmp-6.1.2/ && ./configure && make && sudo make install && cd ..

#### install mpfr
	~$ tar -xvf mpfr-4.0.2.tar.gz
	~$ cd ./mpfr-4.0.2/ && ./configure && make && sudo make install && cd ..

#### install flint2 and arb
	~$ cd ./flint2/ && ./configure && make && sudo make install && cd ..
	~$ cd ./arb/ && ./configure && make && sudo make install && cd ..

### install python-flint for python 2 or python 3
	~$ sudo pip install Cython
	~$ cd ./python-flint  
	~$ sudo python ./setup.py build_ext --include-dirs=/home/(user)/pylibs/flint2:/home/(user)/pylibs/arb --library-dirs=/home/(user)/pylibs/flint2:/home/(user)/pylibs/arb  
	~$ 4. sudo python setup.py install && cd ..  
	~$ export LD_LIBRARY_PATH=/home/(user)/pylibs/flint2:/home/(user)/pylibs/arb:$LD_LIBRARY_PATH
	## put "LD_LIBRARY_PATHPATH" into ".bashrc" of (user) to make PATH permanent
_____________________________
```
##*********************************************************************************
##    Copyright (C) 2020, 2023 Mesut Karakoc
##
##    AIMpy is free software: you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation, either version 3 of the License, or
##    (at your option) any later version.
##
##    AIMpy is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program.  If not, see <https://www.gnu.org/licenses/>.
##*********************************************************************************
```
