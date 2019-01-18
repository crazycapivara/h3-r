H3_VERSION="v3.3.0"
git clone https://github.com/uber/h3.git h3c
pushd h3c
git pull origin master --tags
git checkout "$H3_VERSION"
cmake -DENABLE_FORMAT=OFF -DBUILD_SHARED_LIBS=ON .
sudo make install
popd
sudo rm -rf h3c
