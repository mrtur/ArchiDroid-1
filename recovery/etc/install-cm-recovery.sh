#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8914944 898c7eca6f17cff31b447def54762e308d1bef06 6686720 8f9cdc633954f5f1dffd2b686f72a2fa53ace065
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:8914944:898c7eca6f17cff31b447def54762e308d1bef06; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6686720:8f9cdc633954f5f1dffd2b686f72a2fa53ace065 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 898c7eca6f17cff31b447def54762e308d1bef06 8914944 8f9cdc633954f5f1dffd2b686f72a2fa53ace065:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
