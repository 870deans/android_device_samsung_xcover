#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# WiMAX Support Note: All WiMAX framework and library proprietary blobs
# needed for this build are available at
# http://code.google.com/android/nexus/drivers.html#crespo4g

DEVICE=xcover

rm -rf ../../../vendor/samsung/$DEVICE/*
mkdir -p ../../../vendor/samsung/$DEVICE/proprietary

if [ -f "$1" ]; then
#	rm -rf tmp
#	mkdir tmp
#	unzip -q "$1" -d tmp
#	if [ $? != 0 ]; then
#		echo "$1 is not a valid zip file. Bye."
#		exit 1
#	fi
#	echo "$1 successfully unzip'd. Copying files..."
	ZIP="true"
else
	unset ZIP
fi

DIRS="
etc
bin
cameradata
lib/egl
lib/hw
media
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/samsung/$DEVICE/proprietary/$DIR
done

FILES="
etc/gps.conf
cameradata/datapattern_420sp.yuv
cameradata/datapattern_front_420sp.yuv
cameradata/datapattern_420sp_alkon.yuv
lib/libcamera.so
lib/egl/libEGL_MRVL.so
lib/egl/libGLESv1_CM_MRVL.so
lib/egl/libGLESv2_MRVL.so
lib/hw/sensors.default.so
lib/hw/gps.default.so
lib/hw/lights.default.so
bin/playlpm
bin/charging_mode
lib/libQmageDecoder.so
media/battery_charging_5.qmg
media/battery_charging_10.qmg
media/battery_charging_15.qmg
media/battery_charging_20.qmg
media/battery_charging_25.qmg
media/battery_charging_30.qmg
media/battery_charging_35.qmg
media/battery_charging_40.qmg
media/battery_charging_45.qmg
media/battery_charging_50.qmg
media/battery_charging_55.qmg
media/battery_charging_60.qmg
media/battery_charging_65.qmg
media/battery_charging_70.qmg
media/battery_charging_75.qmg
media/battery_charging_80.qmg
media/battery_charging_85.qmg
media/battery_charging_90.qmg
media/battery_charging_95.qmg
media/battery_charging_100.qmg
media/chargingwarning.qmg
media/Disconnected.qmg
"

for FILE in $FILES; do
	if [ "$ZIP" ]; then
		cp system/"$FILE" ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	else
		adb pull system/$FILE ../../../vendor/samsung/$DEVICE/proprietary/$FILE
	fi
done
#if [ "$ZIP" ]; then rm -rf tmp ; fi

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g > ../../../vendor/samsung/$DEVICE/$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/samsung/__DEVICE__/extract-files.sh

PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/etc/gps.conf:system/etc/gps.conf

#
# Display (3D)
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libEGL_MRVL.so:system/lib/egl/libEGL_MRVL.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv1_CM_MRVL.so:system/lib/egl/libGLESv1_CM_MRVL.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/egl/libGLESv2_MRVL.so:system/lib/egl/libGLESv2_MRVL.so
#    vendor/samsung/__DEVICE__/proprietary/lib/libGAL.so:system/lib/libGAL.so \\
#    vendor/samsung/__DEVICE__/proprietary/lib/libgcu.so:system/lib/libgcu.so

#
# Sensors, Lights etc
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/lights.default.so:system/lib/hw/lights.default.so \\
    vendor/samsung/__DEVICE__/proprietary/lib/hw/gps.default.so:system/lib/hw/gps.default.so \\

#
# Camera
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp.yuv:system/cameradata/datapattern_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_front_420sp.yuv:system/cameradata/datapattern_front_420sp.yuv \\
    vendor/samsung/__DEVICE__/proprietary/cameradata/datapattern_420sp_alkon.yuv:system/cameradata/datapattern_420sp_alkon.yuv \\
    vendor/samsung/__DEVICE__/proprietary/lib/libcamera.so:system/lib/libcamera.so

#
# Files for battery charging screen
#
PRODUCT_COPY_FILES += \\
    vendor/samsung/__DEVICE__/proprietary/bin/playlpm:system/bin/playlpm \\
    vendor/samsung/__DEVICE__/proprietary/bin/charging_mode:system/bin/charging_mode \\
    vendor/samsung/__DEVICE__/proprietary/lib/libQmageDecoder.so:system/lib/libQmageDecoder.so \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_5.qmg:system/media/battery_charging_5.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_10.qmg:system/media/battery_charging_10.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_15.qmg:system/media/battery_charging_15.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_20.qmg:system/media/battery_charging_20.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_25.qmg:system/media/battery_charging_25.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_30.qmg:system/media/battery_charging_30.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_35.qmg:system/media/battery_charging_35.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_40.qmg:system/media/battery_charging_40.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_45.qmg:system/media/battery_charging_45.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_50.qmg:system/media/battery_charging_50.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_55.qmg:system/media/battery_charging_55.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_60.qmg:system/media/battery_charging_60.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_65.qmg:system/media/battery_charging_65.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_70.qmg:system/media/battery_charging_70.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_75.qmg:system/media/battery_charging_75.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_80.qmg:system/media/battery_charging_80.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_85.qmg:system/media/battery_charging_85.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_90.qmg:system/media/battery_charging_90.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_95.qmg:system/media/battery_charging_95.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/battery_charging_100.qmg:system/media/battery_charging_100.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/chargingwarning.qmg:system/media/chargingwarning.qmg \\
    vendor/samsung/__DEVICE__/proprietary/media/Disconnected.qmg:system/media/Disconnected.qmg

EOF

./setup-makefiles.sh
