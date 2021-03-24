DIR=$(pwd)
wget https://www.python.org/ftp/python/3.6.12/Python-3.6.12.tgz   
tar -xvzf Python-3.6.12.tgz
cd Python-3.6.12.tgz
./configure --with-pydebug --without-pymalloc --with-valgrind --prefix /opt/debugpython/
sudo make OPT=-g && sudo make install

## Add python valgrind suppression file
cp $DIR/Python-3.6.12/Misc/valgrind-python.supp $HOME/workspace/incubator-mxnet
echo "Uncomment PyObject_Free and PyObject_Realloc in the valgring suppression file."
