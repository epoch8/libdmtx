echo ========= Remove previous builds
rm -rf _builds
rm -rf DMTX.xcframework

echo ========= Create project structure
cmake -S../ -B_builds -GXcode \
    -DCMAKE_SYSTEM_NAME=iOS \
    "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0 \
    -DCMAKE_INSTALL_PREFIX=`pwd`/_install \
    -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
    -DBUILD_UNIT_TESTS=NO \
    -DBUILD_BLACKBOX_TESTS=NO \
    -DBUILD_EXAMPLES=NO \
    -DBUILD_APPLE_FRAMEWORK=YES
    

echo ========= Build the sdk for iOS
xcodebuild -project _builds/DMTX.xcodeproj build \
    -target dmtx \
    -parallelizeTargets \
    -configuration Release \
    -hideShellScriptEnvironment \
    -sdk iphoneos

echo ========= Build the sdk for simulators
xcodebuild -project _builds/DMTX.xcodeproj build \
    -target dmtx \
    -parallelizeTargets \
    -configuration Release \
    -hideShellScriptEnvironment \
    -sdk iphonesimulator

echo ========= Create the xcframework
xcodebuild -create-xcframework \
    -framework ./_builds/Release-iphonesimulator/dmtx.framework \
    -framework ./_builds/Release-iphoneos/dmtx.framework   \
    -output DMTX.xcframework

echo ========= Copy headers

mkdir DMTX.xcframework/ios-arm64/dmtx.framework/Headers
mkdir DMTX.xcframework/ios-arm64_x86_64-simulator/dmtx.framework/Headers
cp ../dmtx.h DMTX.xcframework/ios-arm64/dmtx.framework/Headers
cp ../dmtx.h DMTX.xcframework/ios-arm64_x86_64-simulator/dmtx.framework/Headers


echo ========= Good job! Now you need to copy in mediapipe repo third_party/dmtx_ios and mobile app







