// Renders the README / pub.dev screenshots into ../doc/screenshots.
//
// Skipped by default. Run from the repo root with:
//   tool/update_screenshots.sh
// or directly (from example/):
//   flutter test --dart-define=SCREENSHOTS=true test/screenshots_test.dart

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvio_ui/nuvio_ui.dart';
import 'package:nuvio_ui_example/gallery/settings.dart';
import 'package:nuvio_ui_example/main.dart';

const _enabled = bool.fromEnvironment('SCREENSHOTS');
const _logicalSize = Size(1280, 800);
const _pixelRatio = 1.25; // 1600 × 1000 output
final _outDir = Directory('../doc/screenshots');

typedef _Action = Future<void> Function(WidgetTester tester);

final _shots = <(String, String, NuvioPalette, _Action?)>[
  ('01-stream-picker', 'Stream picker', NuvioPalette.white, null),
  ('02-overview', 'Overview', NuvioPalette.arcticBlue, null),
  ('03-palettes', 'Palettes', NuvioPalette.gold, null),
  ('04-settings', 'Settings', NuvioPalette.jade, null),
  ('05-chips', 'Chips & pills', NuvioPalette.roseGold, null),
  ('06-inputs', 'Inputs & selection', NuvioPalette.crimson, null),
  (
    '07-dialog',
    'Overlays',
    NuvioPalette.violet,
    (t) => _tap(t, 'Confirm dialog'),
  ),
  (
    '08-bottom-sheet',
    'Overlays',
    NuvioPalette.ocean,
    (t) => _tap(t, 'Open sheet'),
  ),
  (
    '09-feedback',
    'Feedback',
    NuvioPalette.amber,
    (t) async {
      await _tap(t, 'Show toast');
      await _tap(t, 'Simulate download');
      await t.pump(const Duration(milliseconds: 1200));
    },
  ),
  ('10-typography', 'Typography', NuvioPalette.arcticBlue, null),
];

Future<void> _tap(WidgetTester tester, String text) async {
  final finder = find.text(text).first;
  // Bring the control to mid-screen rather than pinned under the app bar.
  Scrollable.ensureVisible(tester.element(finder), alignment: 0.4);
  await tester.pump();
  await tester.tap(finder);
  // First frame starts route/overlay animations; the second lets them finish.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

Future<void> _loadFont(String family, List<String> paths) async {
  final loader = FontLoader(family);
  for (final path in paths) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(path).readAsBytesSync())),
    );
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    if (!_enabled) return;
    await _loadFont(NuvioFonts.jetBrainsSans, [
      '../assets/fonts/JetBrainsSans-Regular.ttf',
      '../assets/fonts/JetBrainsSans-SemiBold.ttf',
      '../assets/fonts/JetBrainsSans-Bold.ttf',
    ]);
    final flutterRoot = Platform.environment['FLUTTER_ROOT']!;
    await _loadFont('MaterialIcons', [
      '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
    ]);
    // Code snippets ask for 'monospace'; use a macOS system mono font.
    await _loadFont('monospace', [
      '/System/Library/Fonts/Supplemental/Andale Mono.ttf',
    ]);
    _outDir.createSync(recursive: true);
  });

  for (final (file, page, palette, action) in _shots) {
    testWidgets('screenshot $file', (tester) async {
      tester.view.physicalSize = _logicalSize;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      debugDisableShadows = false;
      try {
        gallerySettings.value = GallerySettings(palette: palette);
        final boundaryKey = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: boundaryKey,
            child: GalleryApp(initialPage: page),
          ),
        );
        await tester.pump(const Duration(milliseconds: 600));
        if (action != null) await action(tester);

        final boundary =
            boundaryKey.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: _pixelRatio);
          final png = await image.toByteData(format: ui.ImageByteFormat.png);
          File(
            '${_outDir.path}/$file.png',
          ).writeAsBytesSync(png!.buffer.asUint8List());
        });

        // Let toasts and other timers finish before the test ends.
        await tester.pump(const Duration(seconds: 4));
      } finally {
        debugDisableShadows = true;
      }
    }, skip: !_enabled);
  }
}
