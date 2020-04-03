#!/bin/bash

BUILD_DIR=$(realpath .)

sudo apt -y install \
	git \
	g++ \
	libgtk-3-dev \
	gtk-doc-tools \
	gnutls-bin \
	valac \
	libtool \
	intltool \
	libpcre2-dev \
	libglib3.0-cil-dev \
	libgnutls28-dev \
	libgirepository1.0-dev \
	libxml2-utils \
	gperf

git clone -b 0.56.2.a https://github.com/thestinger/vte-ng.git
git clone --recursive -b v15 https://github.com/thestinger/termite.git

cd $BUILD_DIR/vte-ng

NOCONFIGURE=1 ./autogen.sh
./configure \
	--prefix=$BUILD_DIR/vte-static \
	--enable-static \
	--disable-shared \
	--enable-vala=no \
	--disable-gtk-doc \
	--disable-introspection

make
make install
make install-pkgconfigDATA

cd $BUILD_DIR/termite

export PKG_CONFIG_PATH="$BUILD_DIR/vte-static/lib/pkgconfig"
make
sudo make install

sudo cat << EOF > termite.wrapper
#!/bin/bash
exec /usr/local/bin/termite "\$@"
EOF

sudo chmod +x termite.wrapper

sudo install -d /usr/local/bin/
sudo install -m 755 termite.wrapper /usr/local/bin/

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite.wrapper 60

sudo install -d /usr/local/etc/profile.d/
sudo install -m 644 "$BUILD_DIR/vte-static/etc/profile.d/vte.sh" /usr/local/etc/profile.d/

sudo install -d /usr/share/terminfo/
sudo tic -x -o /usr/share/terminfo termite.terminfo
