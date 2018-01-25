#!/bin/bash
# usage:./build_android.sh
# must defind NDK_ROOT
# must under the android ndk r10d/r10e

SYSROOT=${NDK_ROOT}/platforms/android-18/arch-arm/
TOOLCHAIN=${NDK_ROOT}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CPU=arm
PREFIX=../build
EXTRA_CFLAGS="-fdata-sections -ffunction-sections -fstack-protector-strong -ffast-math -fstrict-aliasing -march=armv7-a -mtune=cortex-a8 -mfloat-abi=softfp -mfpu=vfpv3-d16 -D__ANDROID_API__=18 --sysroot $NDK_ROOT/sysroot -isystem $NDK_ROOT/sysroot/usr/include/arm-linux-androideabi"
EXTRA_LDFLAGS="-Wl,--gc-sections -Wl,-z,relro -Wl,-z,now -Wl,--fix-cortex-a8 --sysroot $NDK_ROOT/platforms/android-18/arch-arm"
FFMPEG_CONFIG_FLAGS="--enable-nonfree --enable-gpl --enable-version3 --disable-symver --disable-programs --disable-doc --disable-avdevice --disable-encoders  --disable-muxers --disable-devices --disable-everything  --disable-protocols --disable-demuxers --disable-decoders  --disable-debug --enable-optimizations --disable-filters --disable-avfilter --enable-bsfs --enable-parsers  --disable-parser=hevc --enable-swscale --enable-network --enable-protocol=file --enable-protocol=http --enable-protocol=rtmp --enable-protocol=rtp --enable-protocol=mmst --enable-protocol=mmsh --enable-protocol=crypto --enable-protocol=hls --enable-demuxer=hls --enable-demuxer=mpegts --enable-demuxer=mpegtsraw --enable-demuxer=mpegvideo --enable-demuxer=concat --enable-demuxer=mov --enable-demuxer=flv --enable-demuxer=rtsp --enable-demuxer=mp3 --enable-demuxer=matroska --enable-decoder=mpeg4 --enable-decoder=mpegvideo --enable-decoder=mpeg1video --enable-decoder=mpeg2video --enable-decoder=hevc --enable-decoder=h264 --enable-decoder=h263 --enable-decoder=flv --enable-decoder=vp8 --enable-decoder=rawvideo --enable-decoder=mjpeg --enable-decoder=wmv3 --enable-decoder=aac --enable-decoder=ac3 --enable-decoder=mp3 --enable-decoder=nellymoser --enable-muxer=mp4 --enable-decoder=movtext"

./configure \
--prefix=$PREFIX \
--disable-debug \
--disable-runtime-cpudetect \
--enable-shared \
--disable-static \
--enable-asm \
--enable-neon \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-doc \
--disable-symver \
--enable-pthreads \
--enable-small \
--enable-jni \
--enable-avresample \
--disable-v4l2_m2m \
--disable-postproc \
--enable-thumb \
--enable-mediacodec \
--enable-runtime-cpudetect \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--target-os=android \
--arch=$CPU \
--enable-cross-compile \
--sysroot=$SYSROOT \
${FFMPEG_CONFIG_FLAGS} \
--extra-cflags="$EXTRA_CFLAGS" \
--extra-ldflags="$EXTRA_LDFLAGS" \
$ADDITIONAL_CONFIGURE_FLAG

make clean
make -j4
make install
