#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 9021440 51a778f16eb82bb0479c5fde45c30132af3c635e 6686720 b3db91ce96f20da4a3f25056f3d58f7dd59bb23b
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:9021440:51a778f16eb82bb0479c5fde45c30132af3c635e; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6686720:b3db91ce96f20da4a3f25056f3d58f7dd59bb23b EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 51a778f16eb82bb0479c5fde45c30132af3c635e 9021440 b3db91ce96f20da4a3f25056f3d58f7dd59bb23b:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
