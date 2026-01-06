#!/bin/bash

echo "Building Vim"

pushd /sources

rm -rf vim81
tar -xf vim-8.1.tar.bz2
cd vim81

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

./configure --prefix=/usr || exit 1

make -j$MAKE_JOBS || exit 1

LANG=en_US.UTF-8 make -j1 test &> vim-test.log

make -j$MAKE_JOBS install || exit 1

ln -sv vim /usr/bin/vi
for L in /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim81/doc /usr/share/doc/vim-8.1

# Configuration

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on

if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

cd ..
rm -rf vim81

popd
