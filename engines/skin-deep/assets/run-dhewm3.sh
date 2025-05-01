#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -rsf base/glsl/motionBlurBlendo.frag base/glsl/motionblurBlendo.frag
ln -rsf base/glsl/motionBlurBlendo.vert base/glsl/motionblurBlendo.vert

./skindeep "$@"
