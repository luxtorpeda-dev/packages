#!/bin/bash

# CLONE PHASE
git clone https://github.com/JHGuitarFreak/UQM-MegaMod.git source
pushd source
git checkout "$COMMIT_TAG"
popd

git clone https://github.com/JHGuitarFreak/UQM-MegaMod-Content.git content
pushd content
git checkout "$COMMIT_TAG"
popd

curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/uqm-${COMPAT_VER}-3DOMusicRemastered.uqm"
curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/uqm-${COMPAT_VER}-3dovideo.uqm"
curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/mm-vols-space.uqm"
curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/mm-rmx-utwig.uqm"
curl -sLO "https://gigenet.dl.sourceforge.net/project/uqm-mods/MegaMod/${COMMIT_TAG}/Content/mm-remix-timing.uqm"

# BUILD PHASE
cp -f ./config.state source/config.state
pushd "source"
patch src/config_unix.h.in < ../config_unix.h.in.diff
./build.sh uqm reprocess_config
./build.sh uqm
popd

pushd "content"
zip -5 -r "mm-${COMMIT_TAG}-content.uqm" base/ menu.key uqm.key uqm.rmp
popd
pushd "content/addons"
zip -5 -r "mm-${COMMIT_TAG}-3domode.uqm" 3do-mode-hd/ 3do-mode-sd/
zip -5 -r "mm-${COMMIT_TAG}-3dovoice.uqm" 3dovoice/
zip -5 -r "mm-${COMMIT_TAG}-dosmode.uqm" dos-mode-hd/ dos-mode-sd/
zip -5 -r "mm-${COMMIT_TAG}-hd-classic-pack.uqm" classic-pack/
zip -5 -r "mm-${COMMIT_TAG}-hd-content.uqm" mm-hd/
zip -5 -r "mm-${COMMIT_TAG}-volasaurus-remix-pack.uqm" volasaurus-remix-pack/
popd

# COPY PHASE
cp -v source/UrQuanMasters "${diststart}/2645580/dist/uqm-megamod"
cp -v assets/uqm-megamod.sh "${diststart}/2645580/dist/uqm-megamod.sh"

mkdir -p "${diststart}/2645580/dist/megamod/content/packages" "${diststart}/2645580/dist/megamod/content/addons"
cp -v source/content/version "${diststart}/2645580/dist/megamod/content/version"

cp -v "content/mm-${COMMIT_TAG}-content.uqm" "${diststart}/2645580/dist/megamod/content/packages/mm-${COMMIT_TAG}-content.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-3domode.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-3domode.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-3dovoice.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-3dovoice.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-dosmode.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-dosmode.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-hd-classic-pack.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-hd-classic-pack.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-hd-content.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-hd-content.uqm"
cp -v "content/addons/mm-${COMMIT_TAG}-volasaurus-remix-pack.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-${COMMIT_TAG}-volasaurus-remix-pack.uqm"
cp -v "uqm-${COMPAT_VER}-3DOMusicRemastered.uqm" "${diststart}/2645580/dist/megamod/content/addons/uqm-${COMPAT_VER}-3DOMusicRemastered.uqm"
cp -v "uqm-${COMPAT_VER}-3dovideo.uqm" "${diststart}/2645580/dist/megamod/content/addons/uqm-${COMPAT_VER}-3dovideo.uqm"
cp -v "mm-vols-space.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-vols-space.uqm"
cp -v "mm-rmx-utwig.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-rmx-utwig.uqm"
cp -v "mm-remix-timing.uqm" "${diststart}/2645580/dist/megamod/content/addons/mm-remix-timing.uqm"
