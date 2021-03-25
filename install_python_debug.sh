DIR=$(pwd)
wget https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz
tar -xvzf Python-3.6.12.tgz
cd Python-3.6.12
./configure --with-pydebug --without-pymalloc --with-valgrind --prefix /opt/debugpython/
sudo make OPT=-g && sudo make install

## Add python valgrind suppression file
cp $DIR/Python-3.6.12/Misc/valgrind-python.supp $HOME/workspace/incubator-mxnet
echo "export PATH=/usr/bin:/bin:/opt/debugpython/bin:\$PATH" >> ${HOME}/.bashrc
sudo update-alternatives --install /usr/bin/python python /opt/debugpython/bin/python3 10
echo "Uncomment PyObject_Free and PyObject_Realloc in the valgring suppression file."
