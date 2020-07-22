#/bin/bash

# try to match `unison -version` of other installs, e.g. your mac. OCaml version is easier to control on CloudDesk
unison_ver=2.51.2
ocaml_ver=4.08.1

# build directory, feel free to use your own
mkdir -p ~/Code/unison
cd ~/Code/unison

# build & install ocaml
git clone 'https://github.com/ocaml/ocaml'
cd 'ocaml'
git checkout ${ocaml_ver}
./configure
make world && make opt && sudo make install
cd ..
ocaml --version # run this in a fresh shell to confirm correct version has been installed
# => The OCaml toplevel, version X.XX.X

# build unison (temporary workaround to match OSX's Unison 2.51.2 build /w OCaml v4.08)
git clone https://github.com/bcpierce00/unison.git
cd unison && git checkout acfa10529e1ef073e6f951666159d89e1bda282c # v2.51.2 + compatibility with OCaml v4.08
cp -r src "../unison-${unison_ver}_acfa10529e1ef073e6f951666159d89e1bda282c"
cd ../unison-2.51.2_acfa10529e1ef073e6f951666159d89e1bda282c
make clean && make


# install/link unison to /usr/local/bin
sudo ln -sf $(readlink -f unison) /usr/local/bin/unison
sudo ln -sf $(readlink -f unison-fsmonitor) /usr/local/bin/unison-fsmonitor
