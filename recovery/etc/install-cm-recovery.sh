#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8914944 cc1feeea8bc95156c7ebc26c9a8c1c7e46ffc2e6 6686720 e13e9cb511512e97f77ae16257bf1e13830d7c50
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:8914944:cc1feeea8bc95156c7ebc26c9a8c1c7e46ffc2e6; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6686720:e13e9cb511512e97f77ae16257bf1e13830d7c50 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery cc1feeea8bc95156c7ebc26c9a8c1c7e46ffc2e6 8914944 e13e9cb511512e97f77ae16257bf1e13830d7c50:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
