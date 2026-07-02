#!/usr/bin/env bash


# color codes
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
light_cyan='\033[1;96m'
reset='\033[0m'



# GLOBAL varaibles
BASE_DIR="$HOME/SDRAngel"
BUILD_DIR="$BASE_DIR/build"
INSTALL_DIR="$BASE_DIR/install"

if [[  -d $BASE_DIR  ]] ;then 
    printf "Detected old work dir removing..\n"
    rm -rf $BASE_DIR
    printf "Success..\n"
fi

mkdir $BASE_DIR
mkdir $INSTALL_DIR
mkdir $BUILD_DIR



function INFO_PRINTER(){
    text=$1
    printf "$blue[ INFO ]:$reset $text .\n"
}


function ERR_PRINTER(){
    text=$1
    printf "$red[ ERROR ]:$reset $text .\n"
}


function WARN_PRINTER(){
    text=$1
    printf "$red[ WARN ]:$reset $text .\n"
}


function TITLE_PRINTER(){
    text=$1
    printf "$green<[ $text ]>$reset\n"
}

function CHECK_LAST_COMMAND(){
    if [ "$?" != "0" ] ;then 
        ERR_PRINTER "The previous command failed so the operation is aborted"
        sleep 0.1
        exit 1
    
    else 
        INFO_PRINTER "OK"
    
    fi
}

function CLEAR_AND_CONTINUE(){
    INFO_PRINTER "Clearing screen.."
    sleep 1
    clear
}



TITLE_PRINTER "SDRAngel installer v1.1.0 @ SpectraRF - Claudio Fabiani"
INFO_PRINTER "Printing variables..."

echo 
printf "[ BASE DIR ]: $BASE_DIR\n"
printf "[ BUILD DIR ]: $BUILD_DIR\n"
printf "[ INSTALL DIR ]: $INSTALL_DIR\n"
printf "[ nproc ]: $(nproc)"
printf "[ Arch ] : $(uname -m)"
echo

sleep 1



INFO_PRINTER "Required packages are installed with apt"
sleep 0.1
echo
echo

sudo apt-get update && sudo apt-get -y install \
git cmake g++ pkg-config autoconf automake libtool libfftw3-dev libusb-1.0-0-dev libusb-dev libhidapi-dev libopengl-dev \
libfaad-dev libflac-dev zlib1g-dev libboost-all-dev libasound2-dev pulseaudio libopencv-dev libxml2-dev bison flex flac \
ffmpeg libavcodec-dev libavformat-dev libopus-dev doxygen graphviz libunwind-dev libsndfile-dev libhamlib-dev libhamlib-utils 

CHECK_LAST_COMMAND

sudo apt-get update && sudo apt-get -y install \
qtbase5-dev qtchooser libqt5multimedia5-plugins qtmultimedia5-dev libqt5websockets5-dev \
qttools5-dev qttools5-dev-tools libqt5opengl5-dev libqt5quick5 libqt5location5-plugins libqt5charts5-dev \
qml-module-qtlocation  qml-module-qtpositioning qml-module-qtquick-window2 \
qml-module-qtquick-dialogs qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-layouts \
libqt5serialport5-dev qtdeclarative5-dev qtpositioning5-dev qtlocation5-dev libqt5texttospeech5-dev \
qtwebengine5-dev qtbase5-private-dev libqt5gamepad5-dev libqt5svg5-dev

CHECK_LAST_COMMAND

sudo apt-get update && sudo apt-get -y install \
qt6-base-dev qt6-base-private-dev qt6-scxml-dev \
qt6-multimedia-dev qt6-positioning-dev qt6-websockets-dev qt6-webengine-dev \
qt6-serialport-dev qt6-speech-dev qt6-charts-dev qt6-svg-dev qt6-declarative-dev \
qtchooser qt6-tools-dev qt6-tools-dev-tools libqt6quick6  \
qml-module-qtlocation qml-module-qtpositioning qml-module-qtquick-window2 \
qml-module-qtquick-dialogs qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-layouts

CHECK_LAST_COMMAND

echo
TITLE_PRINTER "Non-hardware dependencies installation starting"
echo
sleep 0.1


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: APT"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/srcejon/aptdec.git
CHECK_LAST_COMMAND

cd aptdec
CHECK_LAST_COMMAND

git checkout libaptdec
CHECK_LAST_COMMAND

git submodule update --init --recursive
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/aptdec ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: CM265cc" 

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/cm256cc.git
CHECK_LAST_COMMAND

cd cm256cc
CHECK_LAST_COMMAND

git reset --hard "v1.1.2"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/cm256cc ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: libDAB"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/srcejon/dab-cmdline
CHECK_LAST_COMMAND

cd dab-cmdline/library
CHECK_LAST_COMMAND

git checkout msvc
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libdab ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND




echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: MBElib" 

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/srcejon/mbelib.git
CHECK_LAST_COMMAND

cd mbelib
CHECK_LAST_COMMAND

git reset --hard 0cf0604433d1409576073d0656926a13287d0de5

CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/mbelib ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND





echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: SerialDV"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/serialDV.git
CHECK_LAST_COMMAND

cd serialDV
CHECK_LAST_COMMAND

git reset --hard "v1.1.5"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/serialdv ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: DSDcc"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/dsdcc.git
CHECK_LAST_COMMAND

cd dsdcc
CHECK_LAST_COMMAND

git reset --hard "v1.9.6"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/dsdcc -DUSE_MBELIB=ON -DLIBMBE_INCLUDE_DIR=$INSTALL_DIR/mbelib/include -DLIBMBE_LIBRARY=$INSTALL_DIR/mbelib/lib/libmbe.so -DLIBSERIALDV_INCLUDE_DIR=$INSTALL_DIR/serialdv/include/serialdv -DLIBSERIALDV_LIBRARY=$INSTALL_DIR/serialdv/lib/libserialdv.so ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND






echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: Codec2/FreeDV"

sudo apt-get -y install libspeexdsp-dev libsamplerate0-dev
CHECK_LAST_COMMAND

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/drowe67/codec2-dev.git codec2
CHECK_LAST_COMMAND

cd codec2
CHECK_LAST_COMMAND

git reset --hard "v1.1.1"
CHECK_LAST_COMMAND

mkdir build_linux; cd build_linux
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/codec2 ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: SGP4"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/dnwrnr/sgp4.git
CHECK_LAST_COMMAND

cd sgp4
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/sgp4 ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: CSPICE"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/srcejon/cspice-cmake.git
CHECK_LAST_COMMAND

cd cspice-cmake
CHECK_LAST_COMMAND

git switch msvc
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/cspice -DCSPICE_BUILD_STATIC_LIBRARY=OFF ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND




echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: LibSigMF"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/libsigmf.git
CHECK_LAST_COMMAND

cd libsigmf
CHECK_LAST_COMMAND

git checkout "new-namespaces"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libsigmf .. 
CHECK_LAST_COMMAND

make -j 1 install
CHECK_LAST_COMMAND



echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: GGMorse"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/ggerganov/ggmorse.git
CHECK_LAST_COMMAND

cd ggmorse
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/ggmorse -DGGMORSE_BUILD_TESTS=OFF -DGGMORSE_BUILD_EXAMPLES=OFF ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND


#echo
#CLEAR_AND_CONTINUE
#INFO_PRINTER "Starting install: RNnoise"
#
#cd $BUILD_DIR
#CHECK_LAST_COMMAND
#
#git clone https://github.com/f4exb/rnnoise
#CHECK_LAST_COMMAND
#
#cd rnnoise
#CHECK_LAST_COMMAND
#
#mkdir build; cd build
#CHECK_LAST_COMMAND
#
#cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/rnnoise ..
#CHECK_LAST_COMMAND
#
#make -j $(nproc) install
#CHECK_LAST_COMMAND



echo
CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install: InmarsatC"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/srcejon/inmarsatc.git
CHECK_LAST_COMMAND

cd inmarsatc
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/inmarsatc ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND




echo 
CLEAR_AND_CONTINUE
TITLE_PRINTER "Starting Hardware dependencies installs"
echo
sleep 1




CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Airspy"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/airspy/airspyone_host.git libairspy
CHECK_LAST_COMMAND

cd libairspy
CHECK_LAST_COMMAND

git reset --hard c6721000f19601512e9ba6b0340e5d9ced22a900
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libairspy ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install HydraSDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/hydrasdr/hydrasdr-host.git
CHECK_LAST_COMMAND

cd hydrasdr-host
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libhydrasdr -DINSTALL_UDEV_RULES=OFF ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND




CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install SDRplay RSP1"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/libmirisdr-4.git
CHECK_LAST_COMMAND

cd libmirisdr-4
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libmirisdr ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install SDRplay (Using SDRplay's V3 API)"

git clone https://github.com/srcejon/sdrplayapi.git
CHECK_LAST_COMMAND

cd sdrplayapi
CHECK_LAST_COMMAND

sudo ./install_lib.sh
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install RTL-SDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/osmocom/rtl-sdr.git librtlsdr
CHECK_LAST_COMMAND

cd librtlsdr
CHECK_LAST_COMMAND

git reset --hard 420086af84d7eaaf98ff948cd11fea2cae71734a
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DDETACH_KERNEL_DRIVER=ON -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/librtlsdr ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



#CLEAR_AND_CONTINUE
#INFO_PRINTER "Starting install Pluto SDR"
#
#cd $BUILD_DIR
#CHECK_LAST_COMMAND
#
#git clone https://github.com/analogdevicesinc/libiio.git
#CHECK_LAST_COMMAND
#
#cd libiio
#CHECK_LAST_COMMAND
#
#git reset --hard v0.26
#CHECK_LAST_COMMAND
#
#mkdir build; cd build
#CHECK_LAST_COMMAND
#
#cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libiio -DINSTALL_UDEV_RULE=OFF ..
#CHECK_LAST_COMMAND
#
#make -j $(nproc) install
#CHECK_LAST_COMMAND




CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install BladeRF all versions"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/Nuand/bladeRF.git
CHECK_LAST_COMMAND

cd bladeRF/host
CHECK_LAST_COMMAND

git reset --hard "2024.05"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libbladeRF -DINSTALL_UDEV_RULES=OFF ..
CHECK_LAST_COMMAND

make -j $(nproc) install 
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install HackRF"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/greatscottgadgets/hackrf.git
CHECK_LAST_COMMAND

cd hackrf/host
CHECK_LAST_COMMAND

git reset --hard "adc537331c5bc3165f47648043c570063518ef79"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libhackrf -DINSTALL_UDEV_RULES=OFF ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install LimeSDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/myriadrf/LimeSuite.git
CHECK_LAST_COMMAND

cd LimeSuite
CHECK_LAST_COMMAND

git reset --hard 524cd2e548b11084e6f739b2dfe0f958c2e30354
CHECK_LAST_COMMAND

mkdir builddir; cd builddir
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$BUILD_DIR/LimeSuite ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install AirspyHF"


cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/airspy/airspyhf
CHECK_LAST_COMMAND

cd airspyhf
CHECK_LAST_COMMAND

git reset --hard 87cf12a30f3a0f10f313aab8e54999ca69b753af
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libairspyhf ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Perseus"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/libperseus-sdr.git
CHECK_LAST_COMMAND

cd libperseus-sdr
CHECK_LAST_COMMAND

git checkout fixes
CHECK_LAST_COMMAND

git reset --hard afefa23e3140ac79d845acb68cf0beeb86d09028
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/libperseus ..
CHECK_LAST_COMMAND

make -j $(nproc)
CHECK_LAST_COMMAND

make install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install USRP"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/EttusResearch/uhd.git
CHECK_LAST_COMMAND

cd uhd
CHECK_LAST_COMMAND

git reset --hard v4.9.0.1
CHECK_LAST_COMMAND

cd host
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/uhd ..
CHECK_LAST_COMMAND

make -j $(nproc)
CHECK_LAST_COMMAND

make install
CHECK_LAST_COMMAND

$INSTALL_DIR/uhd/lib/uhd/utils/uhd_images_downloader.py
CHECK_LAST_COMMAND

echo /opt/install/uhd/lib | sudo dd of=/etc/ld.so.conf.d/uhd.conf
CHECK_LAST_COMMAND

sudo ldconfig
CHECK_LAST_COMMAND

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$INSTALL_DIR/uhd/lib/pkgconfig
CHECK_LAST_COMMAND

cd /opt/install/uhd/lib/uhd/utils
CHECK_LAST_COMMAND

sudo cp uhd-usrp.rules /etc/udev/rules.d/
CHECK_LAST_COMMAND

sudo udevadm control --reload-rules
CHECK_LAST_COMMAND

sudo udevadm trigger
CHECK_LAST_COMMAND




CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install XTRX"


sudo apt-get -y install build-essential libusb-1.0-0-dev cmake dkms python3-cheetah libqcustomplot-dev
CHECK_LAST_COMMAND

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/f4exb/images.git xtrx-images
CHECK_LAST_COMMAND

cd xtrx-images
CHECK_LAST_COMMAND

git submodule init
CHECK_LAST_COMMAND

git submodule update
CHECK_LAST_COMMAND

cd sources
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/xtrx-images -DENABLE_SOAPY=NO ..
CHECK_LAST_COMMAND

make -j $(nproc)
CHECK_LAST_COMMAND

make install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Soapy SDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/pothosware/SoapySDR.git
CHECK_LAST_COMMAND

cd SoapySDR
CHECK_LAST_COMMAND

git reset --hard 1667b4e6301d7ad47b340dcdcd6e9969bf57d843
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/SoapySDR ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Soapy RTL-SDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/pothosware/SoapyRTLSDR.git
CHECK_LAST_COMMAND

cd SoapyRTLSDR
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/SoapySDR  -DRTLSDR_INCLUDE_DIR=$INSTALL_DIR/librtlsdr/include -DRTLSDR_LIBRARY=$INSTALL_DIR/librtlsdr/lib/librtlsdr.so -DSOAPY_SDR_INCLUDE_DIR=$INSTALL_DIR/SoapySDR/include -DSOAPY_SDR_LIBRARY=$INSTALL_DIR/SoapySDR/lib/libSoapySDR.so ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Soapy HackRF"

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/pothosware/SoapyHackRF.git
CHECK_LAST_COMMAND

cd SoapyHackRF
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/SoapySDR -DLIBHACKRF_INCLUDE_DIR=$INSTALL_DIR/libhackrf/include/libhackrf -DLIBHACKRF_LIBRARY=$INSTALL_DIR/libhackrf/lib/libhackrf.so -DSOAPY_SDR_INCLUDE_DIR=$INSTALL_DIR/SoapySDR/include -DSOAPY_SDR_LIBRARY=$INSTALL_DIR/SoapySDR/lib/libSoapySDR.so ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install LimeSDR"

cd $BUILD_DIR
CHECK_LAST_COMMAND

cd LimeSuite/builddir
CHECK_LAST_COMMAND

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/LimeSuite -DCMAKE_PREFIX_PATH=$INSTALL_DIR/SoapySDR ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND

cp $INSTALL_DIR/LimeSuite/lib/SoapySDR/modules0.8/libLMS7Support.so $INSTALL_DIR/SoapySDR/lib/SoapySDR/modules0.8


CLEAR_AND_CONTINUE
INFO_PRINTER "Starting install Soapy Remote"

sudo apt-get -y install libavahi-client-dev
CHECK_LAST_COMMAND

cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/pothosware/SoapyRemote.git
CHECK_LAST_COMMAND

cd SoapyRemote
CHECK_LAST_COMMAND

git reset --hard "soapy-remote-0.5.1"
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/SoapySDR -DSOAPY_SDR_INCLUDE_DIR=$INSTALL_DIR/SoapySDR/include -DSOAPY_SDR_LIBRARY=$INSTALL_DIR/SoapySDR/lib/libSoapySDR.so ..
CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND



echo 
CLEAR_AND_CONTINUE
INFO_PRINTER "Proccess complated."
INFO_PRINTER "Starting main build"
sleep 0.5


cd $BUILD_DIR
CHECK_LAST_COMMAND

git clone https://github.com/rdsantos18/sdrangel.git
CHECK_LAST_COMMAND

cd sdrangel
CHECK_LAST_COMMAND

mkdir build; cd build
CHECK_LAST_COMMAND

INFO_PRINTER "Starting cmake build.."

cmake -Wno-dev -DDEBUG_OUTPUT=ON -DRX_SAMPLE_24BIT=ON \
-DCMAKE_BUILD_TYPE=RelWithDebInfo \
-DMIRISDR_DIR=/opt/install/libmirisdr \
-DAIRSPY_DIR=/opt/install/libairspy \
-DAIRSPYHF_DIR=/opt/install/libairspyhf \
-DBLADERF_DIR=/opt/install/libbladeRF \
-DHACKRF_DIR=/opt/install/libhackrf \
-DRTLSDR_DIR=/opt/install/librtlsdr \
-DLIMESUITE_DIR=/opt/install/LimeSuite \
-DIIO_DIR=/opt/install/libiio \
-DPERSEUS_DIR=/opt/install/libperseus \
-DXTRX_DIR=/opt/install/xtrx-images \
-DSOAPYSDR_DIR=/opt/install/SoapySDR \
-DUHD_DIR=/opt/install/uhd \
-DAPT_DIR=/opt/install/aptdec \
-DCM256CC_DIR=/opt/install/cm256cc \
-DDSDCC_DIR=/opt/install/dsdcc \
-DSERIALDV_DIR=/opt/install/serialdv \
-DMBE_DIR=/opt/install/mbelib \
-DCODEC2_DIR=/opt/install/codec2 \
-DSGP4_DIR=/opt/install/sgp4 \
-DCSPICE_DIR=/opt/install/cspice \
-DLIBSIGMF_DIR=/opt/install/libsigmf \
-DDAB_DIR=/opt/install/libdab \
-DGGMORSE_DIR=/opt/install/ggmorse \
-DRNNOISE_DIR=/opt/install/rnnoise \
-DINMARSATC_DIR=/opt/install/inmarsatc \
-DCMAKE_INSTALL_PREFIX=/opt/install/sdrangel ..

CHECK_LAST_COMMAND

make -j $(nproc) install
CHECK_LAST_COMMAND

