# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=1
device.name1=mido
supported.versions=10-11
supported.patchlevels=2020-01-
'; }
# end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## remove predefined i/o scheduler properties by @MrCarb0n
PBP=/system/product/build.prop;
PROP=persist.sys.io.scheduler
if [ "$(grep -c $PROP $PBP)" == "1" ]; then
    mount -o rw,remount -t auto /system >/dev/null;
    restore_file $PBP;
    backup_file $PBP;
    remove_line $PBP $PROP;
fi;

## AnyKernel boot install
dump_boot;

write_boot;
## end boot install


# shell variables
#block=vendor_boot;
#is_slot_device=1;
#ramdisk_compression=auto;
#patch_vbmeta_flag=auto;

# reset for vendor_boot patching
#reset_ak;


## AnyKernel vendor_boot install
#split_boot; # skip unpack/repack ramdisk since we don't need vendor_ramdisk access

#flash_boot;
## end vendor_boot install
