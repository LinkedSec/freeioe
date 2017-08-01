# !/usr/bin/env sh

rm __release/* -rf
# Make the release folder
mkdir -p __release

# Clean up the cramfs folder
#sudo rm -rf __install
rm -rf __install
mkdir __install

# Copy files
cp -r lualib __install/lualib
cp -r service __install/service
cp -r snax __install/snax
cp config __install/
cp main.lua __install/
cp preload.lua __install/
cp README.md __install/

# copy lwf files

### Get the version by count the commits
VERSION=`git log --oneline | wc -l | tr -d ' '`

### Generate the revision by last commit
set -- $(git log -1 --format="%ct %h")
R_SECS="$(($1 % 86400))"
R_YDAY="$(date --utc --date="@$1" "+%y.%j")"
REVISION="$(printf 'git-%s.%05d-%s' "$R_YDAY" "$R_SECS" "$2")"

echo 'Version:'$VERSION
echo 'Revision:'$REVISION
echo $VERSION > __install/version
echo $REVISION >> __install/version

# For pre-installed applications
mkdir __install/apps
./scripts/pre_inst.sh iot iot 1.2.0

# Compile lua files
# ./scripts/compile_lua.sh 

# Create the cramfs image
#sudo chown -R root:root __install
#mkfs.cramfs __install __release/skynet_iot.$VERSION.cramfs
mksquashfs __install __release/core_gz.$VERSION.sfs -all-root > /dev/null
#mksquashfs __install __release/skynet_iot_mips.sfs -nopad -noappend -root-owned -comp xz -Xpreset 9 -Xe -Xlc 0 -Xlp 2 -Xpb 2
mksquashfs __install __release/core_xz.$VERSION.sfs -all-root -comp xz > /dev/null

#################################
# Count the file sizes
################################
du __install -sh
du __release/* -sh

# Clean up the rootfs files
#sudo rm -rf __install
rm -rf __install

# Release example (modbus)
# Release iot
./scripts/release_app.sh iot

###################
##
##################
cd __release
mkdir skynet_iot-1.0
cp core_xz.$VERSION.sfs skynet_iot-1.0/skynet_iot.sfs
tar czvf skynet_iot-1.0.tar.gz skynet_iot-1.0 > /dev/null
rm -rf skynet_iot-1.0

cd - > /dev/null
# Done
echo 'May GOD with YOU always!'