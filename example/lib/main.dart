// nuvio_ui gallery: browse every token and component, tweak them live and
// copy the code. Run: cd example && fvm flutter run -d macos

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import 'gallery/settings.dart';
import 'gallery/shell.dart';

void main() => runApp(const GalleryApp());

class GalleryApp extends HookWidget {
  const GalleryApp({super.key, this.initialPage});

  /// Title of the gallery page to open first (defaults to the overview).
  final String? initialPage;

  @override
  Widget build(BuildContext context) {
    final settings = useValueListenable(gallerySettings);
    return MaterialApp(
      title: 'nuvio_ui gallery',
      debugShowCheckedModeBanner: false,
      theme: NuvioThemeData.build(settings.palette, amoled: settings.amoled),
      home: GalleryShell(initialPage: initialPage),
    );
  }
}
