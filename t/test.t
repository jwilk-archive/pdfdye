#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..1
base="${0%/*}/.."
tmpdir=$(mktemp -d -t pdfdye.XXXXXX)
"$base/pdfdye" --color '17252A' "$base/t/test.pdf" "$tmpdir/test.pdf"
pdftoppm "$tmpdir/test.pdf" > "$tmpdir/test.ppm"
histogram=$(ppmhist < "$tmpdir/test.ppm")
if grep -E ' 23 +37 +42	' >/dev/null <<<"$histogram"
then
    echo ok 1
else
    echo not ok 1
fi
rm -rf "$tmpdir"

# vim:ts=4 sts=4 sw=4 et ft=sh
