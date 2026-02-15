#!/bin/bash
set -e

echo "Compiling Metal Kernel..."
echo "Compiling Metal Kernel..."
xcrun -sdk macosx metal -fcikernel -c toGainMapHDR/CustomFilter/GainMapKernel.ci.metal -o GainMapKernel.ci.air
xcrun -sdk macosx metallib GainMapKernel.ci.air -o bin/GainMapKernel.ci.metallib

echo "Compiling Swift Tool..."
swiftc toGainMapHDR/main.swift toGainMapHDR/CustomFilter/GainMapFilter.swift -o bin/toGainMapHDR

echo "Build Complete. Executable: ./bin/toGainMapHDR"
