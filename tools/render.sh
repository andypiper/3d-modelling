#!/bin/bash
# from https://calbryant.uk/blog/10-ways-to-get-the-best-out-of-openscad/#for-3d-renderings

set -e

openscad=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

input_stl=$(realpath $1)
dirname=$(dirname $1)
basename=$(basename -s .stl $1)
tmp_scad=tmp/$$.scad
tmp_png=tmp/$$.png
final_png=${dirname}/${basename}.png

mkdir -p tmp

printf 'import("%s", convexity=10);' ${input_stl} > ${tmp_scad}

# Starnight chosen as the background never occurs in the foreground. This
# allows the background to be subtracted with no artifacts.
${openscad} \
    --hardwarnings \
    --autocenter \
    --viewall \
    --imgsize=9600,9600 \
    --colorscheme Starnight \
    ${tmp_scad} \
    -o ${tmp_png}

# For drop shadow change memory and disk limit from 256MiB in /etc/ImageMagick-6/policy.xml
# remove background colour
# desaturate
# 8x exact downscale for 8x anti-aliasing
# shadow added to improve edges against background
# trim (needs repage)
convert ${tmp_png} \
    -transparent 'rgb(0,0,0)' \
    -modulate 100,0,100 \
    -resize 12.5% \
    \
    -bordercolor None -border 7x7 \
    \( +clone -background black -shadow 70x2+0+0 \) \
    -background none \
    -compose DstOver \
    -flatten -compose Over \
    \
    -trim +repage \
    ${final_png}

optipng ${final_png}

rm ${tmp_scad}
rm ${tmp_png}
