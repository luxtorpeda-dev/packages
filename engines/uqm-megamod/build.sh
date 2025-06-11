#!/bin/bash

# CLONE PHASE
git clone https://github.com/JHGuitarFreak/UQM-MegaMod.git source
pushd source
git checkout "$COMMIT_TAG"
popd

for i in ${UQM_PACKAGES[@]} ${UQM_ADDONS[@]}; do
  curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/${i}"
done

# BUILD PHASE
cp -rfv ./config.state source
pushd "source"
patch src/config_unix.h.in < ../config_unix.h.in.diff
./build.sh uqm reprocess_config
./build.sh uqm
popd

# COPY PHASE
cp -v source/UrQuanMasters "${diststart}/2645580/dist/uqm-megamod"
cp -v assets/uqm-megamod.sh "${diststart}/2645580/dist/uqm-megamod.sh"

mkdir -p "${diststart}/2645580/dist/megamod/content/packages"
for i in ${UQM_PACKAGES[@]}; do
  cp -rvf "${i}" "${diststart}/2645580/dist/megamod/content/packages/${i}"
done

mkdir -p "${diststart}/2645580/dist/megamod/content/addons"
for i in ${UQM_ADDONS[@]}; do
  cp -rvf "${i}" "${diststart}/2645580/dist/megamod/content/addons/${i}"
done

echo -e "${COMMIT_TAG}"'\n\n$Format:%ad$' > "${diststart}/2645580/dist/megamod/content/version"

unset UQM_PACKAGES UQM_ADDONS
