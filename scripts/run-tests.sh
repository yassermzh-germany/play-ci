packages=$(./scripts/detect-changed-packages.sh)
echo "packages=$packages"
set -o pipefail
PACKAGE="$packages" node jasmine.js | tee ./logs
if [ $? -eq 0 ]
then
  exit 0
else
  cat ./logs | grep "No specs defined" -q && exit 0
  exit 1
fi