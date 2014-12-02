#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8914944 874729ec08d90c0404cd73340d78735fcbce27c6 6686720 ec7e18ca0e14c95f35de096d162c5a84a24c9428
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:8914944:874729ec08d90c0404cd73340d78735fcbce27c6; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6686720:ec7e18ca0e14c95f35de096d162c5a84a24c9428 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 874729ec08d90c0404cd73340d78735fcbce27c6 8914944 ec7e18ca0e14c95f35de096d162c5a84a24c9428:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
