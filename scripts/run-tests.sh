packages=$(./scripts/detect-changed-packages.sh)
echo "packages=$packages"
#packages="+(spec)"
PACKAGE="$packages" node jasmine.js
