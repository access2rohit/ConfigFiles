DIR=$(pwd)
VERSION=3.7.10
wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
tar -xvzf Python-$VERSION.tgz
cd Python-$VERSION
./configure --with-pydebug --without-pymalloc --with-valgrind --prefix /opt/debugpython/
sudo make OPT=-g && sudo make install

## Add python valgrind suppression file
cp $DIR/Python-$VERSION/Misc/valgrind-python.supp $HOME/workspace/incubator-mxnet
echo "export PATH=/usr/bin:/bin:/opt/debugpython/bin:\$PATH" >> ${HOME}/.bashrc
sudo update-alternatives --install /usr/bin/python python /opt/debugpython/bin/python3 10

/opt/debugpython/bin/python3 -m venv $HOME/virtualenv/pytest
source $HOME/virtualenv/pytest/bin/activate
/opt/debugpython/bin/python3 -m pip install numpy==1.19
/opt/debugpython/bin/python3 -m pip install scikit-learn
/opt/debugpython/bin/python3 -m pip install requests
/opt/debugpython/bin/python3 -m pip install contextvars
/opt/debugpython/bin/python3 -m pip install nose
/opt/debugpython/bin/python3 -m pip install pytest
deactivate

rm ../Python-$VERSION.tgz
echo "Uncomment PyObject_Free and PyObject_Realloc in the valgring suppression file."
