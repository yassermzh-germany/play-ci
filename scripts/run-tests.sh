packages=$(sh ./scripts/detect-changed-packages.sh)
PACKAGE="$packages" node jasmine.js