import 'package:flutter/foundation.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

@immutable
class GallerySettings {
  const GallerySettings({
    this.palette = NuvioPalette.arcticBlue,
    this.amoled = false,
  });

  final NuvioPalette palette;
  final bool amoled;

  GallerySettings copyWith({NuvioPalette? palette, bool? amoled}) =>
      GallerySettings(
        palette: palette ?? this.palette,
        amoled: amoled ?? this.amoled,
      );
}

/// App-wide gallery state; read it with `useValueListenable(gallerySettings)`.
final gallerySettings = ValueNotifier(const GallerySettings());

void selectPalette(NuvioPalette p) =>
    gallerySettings.value = gallerySettings.value.copyWith(palette: p);

void setAmoled(bool v) =>
    gallerySettings.value = gallerySettings.value.copyWith(amoled: v);
