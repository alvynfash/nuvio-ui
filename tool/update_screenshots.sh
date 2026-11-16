#!/bin/sh
# Regenerates doc/screenshots (README + pub.dev listing) from the example
# gallery. macOS only: uses system fonts for code snippets and `sips` for JPEG.
#   tool/update_screenshots.sh            # uses `flutter`
#   FLUTTER="fvm flutter" tool/update_screenshots.sh
set -e
FLUTTER=${FLUTTER:-flutter}
cd "$(dirname "$0")/../example"
$FLUTTER test --dart-define=SCREENSHOTS=true test/screenshots_test.dart
cd ../doc/screenshots
for f in *.png; do
  sips -s format jpeg -s formatOptions 85 "$f" --out "${f%.png}.jpg" >/dev/null
  rm "$f"
done
ls -lh
