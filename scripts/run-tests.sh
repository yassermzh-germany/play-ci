packages=$(./scripts/detect-changed-packages.sh)
echo "packages=$packages"
# set -o pipefail
PACKAGE="$packages" node jasmine.js | tee ./logs
grep -q Failed ./logs && exit 1
# grep "No specs defined" -q ./logs && exit 0
exit 0
