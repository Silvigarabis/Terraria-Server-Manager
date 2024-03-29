#!/bin/bash

download_api="https://terraria.org/api/download/mobile-dedicated-server"

server="server"
tmpdir=".tmp.$RANDOM"
server_linux="ServerLinux"

basename="MobileTerrariaServer.zip"
linux_name="Linux_MobileServer_1_4_0_5.zip"

link="${download_api}/${basename}"
file="${tmpdir}/${basename}"

sha256="dbe3f38c1184e22ae688f55bf556418c5897f6ae3f3d6695bd2178f17a86d2b1"

mkdir "${tmpdir}" || exit $?
#wget -O "${file}" "${link}"
cp \
  "${basename}" \
  "${file}" || exit $?

file_sha256=$(info=$(sha256sum "${file}") && printf "${REPLY%% *}")

if [ "${file_sha256}" != "${sha256}" ]; then
  echo "downloaded file' s SHA256 do not match the internal specified, maybe there is a broken file, or the game had updated"
  rm -rf "${tmpdir}"
  exit 1
fi

unzip -d "${tmpdir}" "${file}"
unzip "${tmpdir}/${linux_name}"
mv "${server_linux}" "${server}"
rm -rf "${tmpdir}"
chmod +x "${server}/TerrariaServer"*
