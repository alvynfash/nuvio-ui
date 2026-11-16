import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvio_ui_example/gallery/shell.dart';
import 'package:nuvio_ui_example/main.dart';

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
}
