sudo apt-get install build-essential

cd /tmp
wget http://www.immunitysec.com/downloads/SPIKE2.9.tgz
tar -xzvf SPIKE2.9.tgz
cd SPIKE/SPIKE/src
./configure
make
sudo mv -i /tmp/SPIKE ~/scripts/
