#!/bin/sh

if [ ! -e /System/Library/Disabled ]; then
    mkdir /System/Library/Disabled
fi
if [ `kextstat | grep -c com.apple.driver.AppleThunderboltIP` -gt 0 ]; then
    kextunload -b com.apple.driver.AppleThunderboltIP
    mv /System/Library/Extensions/AppleThunderboltIP.kext /System/Library/Disabled/
fi
if [ `kextstat | grep -c com.apple.driver.AppleThunderboltDPInAdapter` -gt 0 ]; then
    kextunload -b com.apple.driver.AppleThunderboltDPInAdapter
    mv /System/Library/Extensions/AppleThunderboltDPAdapters.kext /System/Library/Disabled/
fi
if [ `kextstat | grep -c com.apple.driver.AppleThunderboltDPAdapterFamily` -gt 0 ]; then
    kextunload -b com.apple.driver.AppleThunderboltDPAdapterFamily
fi
if [ `kextstat | grep -c com.apple.driver.AppleThunderboltPCIDownAdapter` -gt 0 ]; then
    kextunload -b com.apple.driver.AppleThunderboltPCIDownAdapter
    mv /System/Library/Extensions/AppleThunderboltPCIAdapters.kext /System/Library/Disabled/
fi

exit 0