# Script to Fix Color Problem for U-boot Galaxy Nexus Kernel
tput setaf 6
setterm -bold 
echo "**** KERNEL Color Fix ****"
echo "**** FOR I9250 ****"
echo "**** By dlhxr ****"
tput sgr0 
setterm -bold 
tput setaf 1
echo "Checking stale files"
if test -e ./out/2nd.img.fixed
then rm -r ./out/2nd.img.fixed
fi
if test -d tmp
then rm -rf tmp
fi
tput setaf 6
echo "Checking for 2nd.img"
if test -e ./out/2nd.img
  then
   mkdir tmp
   echo "Extracting Kernel + Ramdisk + Parameter" 
   ./tools/unpackbootimg -i out/2nd.img -o tmp 
   tput setaf 2
   ./tools/mkbootimg --kernel tmp/2nd.img-zImage --ramdisk tmp/2nd.img-ramdisk.gz -o out/2nd.img.fixed --base 0x$(cat tmp/2nd.img-base) --pagesize $(cat tmp/2nd.img-pagesize) --cmdline '"$(cat tmp/2nd.img-cmdline)" mms_ts.panel_id=18'
   sleep 2
   rm -rf tmp
   echo "Color Fixed. Please copy 2nd.img.fixed to /data/media/boot/2nd.img"
   tput sgr0
else echo "2nd.img not found!"
fi
