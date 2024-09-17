#!/bin/sh

set -e

# Export environment variables to use the correct toolchain
export CC=/opt/miyoomini-toolchain/usr/bin/arm-linux-gnueabihf-gcc
export CXX=/opt/miyoomini-toolchain/usr/bin/arm-linux-gnueabihf-g++
export AR=/opt/miyoomini-toolchain/usr/bin/arm-linux-gnueabihf-ar
export SYSROOT=/opt/miyoomini-toolchain/arm-buildroot-linux-gnueabihf/sysroot
export CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_LINKER=$CC
export CARGO_TARGET_ARMV7_UNKNOWN_LINUX_GNUEABIHF_RUSTFLAGS="-C link-arg=--sysroot=$SYSROOT"

build_dir=build/build-linux-armv7

# create file structure
mkdir -p build/
rm -rf $build_dir
mkdir -p $build_dir
mkdir -p $build_dir/drive/
mkdir -p $build_dir/drive/screenshots/
mkdir -p $build_dir/drive/carts/
mkdir -p $build_dir/drive/carts/screenshots/

# build executables using the standard Rust target
cargo build --release

# install files
cp -r drive/carts/ $build_dir/drive/carts
cp drive/config_template.txt $build_dir/drive/config.txt

cp target/armv7-unknown-linux-gnueabihf/release/picolauncher $build_dir/picolauncher
cp target/armv7-unknown-linux-gnueabihf/release/p8util $build_dir/p8util

zip -r picolauncher-linux-miyoomini.zip $build_dir
