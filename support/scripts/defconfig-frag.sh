#!/bin/sh
# Usage: support/scripts/defconfig-frag.sh [-O outdir] <board>_defconfig <fragment>...
# Loads a defconfig, merges config fragments on top (later wins), then
# resolves dependencies with olddefconfig. Fragments may be bare names
# (looked up in configs/, ".fragment" optional) or paths.
set -e
TOP=$(cd "$(dirname "$0")/../.." && pwd)
OUT="$TOP"
if [ "$1" = "-O" ]; then OUT=$(readlink -f "$2"); shift 2; fi
[ $# -ge 2 ] || { sed -n 2,5p "$0"; exit 1; }
DEF=$1; shift
FRAGS=
for f in "$@"; do
	for c in "$f" "$TOP/configs/$f" "$TOP/configs/$f.fragment"; do
		[ -f "$c" ] && { FRAGS="$FRAGS $c"; continue 2; }
	done
	echo "fragment not found: $f" >&2; exit 1
done
O_ARG=; [ "$OUT" = "$TOP" ] || O_ARG="O=$OUT"
make -C "$TOP" $O_ARG "$DEF"
KCONFIG_CONFIG="$OUT/.config" "$TOP/support/kconfig/merge_config.sh" -m "$OUT/.config" $FRAGS
make -C "$TOP" $O_ARG olddefconfig
