echo "Setting up Build Environment"

export CROSS_COMPILE=~/android/toolchain/bin/aarch64-linux-android-
export ARCH=arm64
export SUBARCH=arm64
export USE_CCACHE=1
mkdir -p out

echo "Building Kernel"

make O=out lineageos_zerofltexx_defconfig
make O=out -j10

echo "Building dtb"

mv out/arch/arm64/boot/dts/exynos7420-zeroflte_eur_open_0* dtb/
scripts/dtbtool -o "build/ak3/" -d dtb/ -s 2048
mv out/arch/arm64/boot/Image build/ak3/
echo "Creating flashables..."
cd build/ak3
zip -r9 ../G920X-Optimized-v1.1.zip * -x README.md ../G920X-Optimized-v1.1.zip
echo "Done, your flashable can be found at build/"


