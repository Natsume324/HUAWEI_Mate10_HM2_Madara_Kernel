export PATH=$PATH:/root/clang-r353983c/bin:/root/android10-gcc4.9/bin
export CLANG_PREBUILTS_PATH=/root/clang-r353983c/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/clang-r353983cc/lib64/
export CROSS_COMPILE=aarch64-linux-android-
export ARCH=arm64
export CC=clang
mkdir out
make ARCH=arm64 O=out CC="ccache clang" merge_kirin970_defconfig
make ARCH=arm64 O=out CC="ccache clang" -j$(nproc --all) 2>&1 | tee build.log
