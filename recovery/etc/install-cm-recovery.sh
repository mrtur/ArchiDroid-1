#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8914944 1a49881d92f7399f1e0908075da7208d75e9a047 6686720 9377c1efa8830cf65088a7292a5fe4e6ea50a3e7
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:8914944:1a49881d92f7399f1e0908075da7208d75e9a047; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6686720:9377c1efa8830cf65088a7292a5fe4e6ea50a3e7 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 1a49881d92f7399f1e0908075da7208d75e9a047 8914944 9377c1efa8830cf65088a7292a5fe4e6ea50a3e7:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
