#!/bin/bash

echo "Building Ninja"

pushd /sources

rm -rf ninja-1.9.0
tar -xf ninja-1.9.0.tar.gz
cd ninja-1.9.0

export NINJAJOBS=$MAKE_JOBS

sed -i '/int Guess/a \
    int   j = 0;\
    char* jobs = getenv("NINJAJOBS");\
    if (jobs != NULL) j = atoi(jobs);\
    if (j > 0) return j;\
' src/ninja.cc

python3 configure.py --bootstrap || exit 1

python3 configure.py || exit 1
./ninja ninja_test
./ninja_test --gtest_filter=-SubprocessTest.SetWithLots

install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja

cd ..
rm -rf ninja-1.9.0

popd
