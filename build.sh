#!/bin/bash
set -e

echo "Compiling Metal Kernel..."
echo "Compiling Metal Kernel..."
xcrun -sdk macosx metal -fcikernel -c toGainMapHDR/CustomFilter/GainMapKernel.ci.metal -o GainMapKernel.ci.air
xcrun -sdk macosx metallib GainMapKernel.ci.air -o bin/GainMapKernel.ci.metallib

echo "Compiling libultrahdr (ultrahdr_app)..."
# Build libultrahdr if not already built or if forced
if [ ! -f "libultrahdr/build_directory/ultrahdr_app" ]; then
    mkdir -p libultrahdr/build_directory
    pushd libultrahdr/build_directory
    cmake -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DUHDR_BUILD_TESTS=0 ../
    ninja ultrahdr_app
    popd
else
    echo "ultrahdr_app already built. Skipping cmake/ninja."
fi

# Copy ultrahdr_app to bin/
cp libultrahdr/build_directory/ultrahdr_app bin/
echo "Copied ultrahdr_app to bin/"

echo "Compiling Swift Tool..."
swiftc toGainMapHDR/main.swift toGainMapHDR/CustomFilter/GainMapFilter.swift -o bin/toGainMapHDR

echo "Build Complete. Executables: ./bin/toGainMapHDR, ./bin/ultrahdr_app"
