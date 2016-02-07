###
### Description: Android SDK NDK config
### Author: devnull@libcrack.so
### Date: Mon mar 16 03:49:30 CET 2015
###

export ANDROID_HOME="${HOME}/Android"
export ANDROID_NDK_ROOT="${ANDROID_HOME}/ndk"
export ANDROID_SDK_ROOT="${ANDROID_HOME}/sdk"

export ANDROID_TOOLS="${ANDROID_SDK_ROOT}/tools"
export ANDROID_PLATFORM_TOOLS="${ANDROID_SDK_ROOT}/platform-tools"
#export ANDROID_TOOLCHAIN="${ANDROID_NDK_ROOT}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin"
export ANDROID_TOOLCHAIN="${ANDROID_HOME}/toolchain/bin"

# # Available tool chains at ${ANDROID_NDK_ROOT}/toolchains
# ${ANDROID_NDK_ROOT}/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/llvm-3.3/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/mipsel-linux-android-clang3.3/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/x86-4.8/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/arm-linux-androideabi-4.8/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/mipsel-linux-android-4.6/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/renderscript/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/x86-clang3.3/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/arm-linux-androideabi-clang3.3/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/mipsel-linux-android-4.8/prebuilt/linux-x86_64/bin
# ${ANDROID_NDK_ROOT}/toolchains/x86-4.6/prebuilt/linux-x86_64/bin

# # GDB Server (choose just one depending on the targeted Android ABI)"
# PATH="${$ANDROID_SDK_ROOT}/prebuilt/android-x86/gdbserver:${PATH}"
# PATH="${ANDROID_SDK_ROOT}/prebuilt/android-arm/gdbserver:${PATH}"
# PATH="${ANDROID_SDK_ROOT}/prebuilt/android-mips/gdbserver:${PATH}"

# # Android misc tools
# PATH="${ANDROID_SDK_ROOT}/platform-tools/systrace:${PATH}"
# PATH="${ANDROID_SDK_ROOT}/prebuilt/common/scan-view:${PATH}"
# PATH="${ANDROID_SDK_ROOT}/prebuilt/common/scan-build:${PATH}"
# PATH="${ANDROID_SDK_ROOT}/tools/proguard/bin:${PATH}"

# Android tools, platform tools and toolchain
export PATH="${ANDROID_NDK_ROOT}:${PATH}"
export PATH="${ANDROID_TOOLS}:${PATH}"
export PATH="${ANDROID_PLATFORM_TOOLS}:${PATH}"
# export PATH="${ANDROID_TOOLCHAIN}:${PATH}"
export PATH="${PATH}:${ANDROID_TOOLCHAIN}"

alias adbforward="adb forward tcp:31415 tcp:31415"
