FROM ubuntu:18.04

RUN apt-get update\
 && apt-get install -y --no-install-recommends\
 g++\
 ninja-build\
 cmake\
 uuid-dev\
 libboost-filesystem-dev\
 omniorb-nameserver\
 libomniorb4-dev\
 omniidl\
 python\
 wget\
 && apt-get clean\
 && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate -O - 'https://github.com/OpenRTM/OpenRTM-aist/archive/master.tar.gz'\
 | tar xzf -
RUN cmake -G Ninja -S /OpenRTM-aist-master -B/tmp/build\
 -G Ninja\
 -DCMAKE_BUILD_TYPE=Release\
 -DSSL_ENABLE=ON\
 -DOBSERVER_ENABLE=ON\
 -DCMAKE_INSTALL_PREFIX=/opt/openrtm
RUN cmake --build /tmp/build --target install/strip
