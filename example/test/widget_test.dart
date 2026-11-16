import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvio_ui/nuvio_ui.dart';
import 'package:nuvio_ui_example/gallery/shell.dart';
import 'package:nuvio_ui_example/main.dart';
import 'package:nuvio_ui_example/quick_start.dart';

void main() {
  testWidgets('every gallery page renders without errors', (tester) async {
    tester.view.physicalSize = const Size(1600, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GalleryApp());
    await tester.pump(const Duration(milliseconds: 500));

    for (final entry in galleryEntries) {
      await tester.tap(find.text(entry.title).first);
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull, reason: entry.title);
    }
  });

  testWidgets('quick start app renders and opens a dialog', (tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const QuickStartApp());
    await tester.tap(find.text('1080p'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(NuvioDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
