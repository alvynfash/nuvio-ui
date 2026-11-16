// Type scale (NuvioTokens.Type / LineHeight / LetterSpacing, NuvioTypeScale and
// the Material Typography overrides in ThemeKt.getNuvioTypography).
// Compose sp == Flutter fontSize; Flutter `height` is lineHeight / fontSize.

import 'package:flutter/material.dart';

TextStyle _style(String? family, double size, double lineHeight,
        FontWeight weight, [double letterSpacing = 0]) =>
    TextStyle(
      fontFamily: family,
      fontSize: size,
      height: lineHeight / size,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    );

/// Nuvio's own type ramp, available as `context.nuvioType`.
@immutable
class NuvioTypeScale extends ThemeExtension<NuvioTypeScale> {
  NuvioTypeScale({this.fontFamily})
      : labelXs = _style(fontFamily, 11, 14, FontWeight.w600),
        labelSm = _style(fontFamily, 12, 15, FontWeight.w600),
        bodySm = _style(fontFamily, 13, 18, FontWeight.w400),
        bodyMd = _style(fontFamily, 14, 20, FontWeight.w400),
        bodyLg = _style(fontFamily, 16, 22, FontWeight.w400),
        titleSm = _style(fontFamily, 18, 22, FontWeight.w600),
        titleMd = _style(fontFamily, 22, 26, FontWeight.w600),
        titleLg = _style(fontFamily, 28, 32, FontWeight.w600),
        displaySm = _style(fontFamily, 32, 36, FontWeight.w700),
        displayMd = _style(fontFamily, 48, 52, FontWeight.w700),
        pageDisplay = _style(fontFamily, 38, 42, FontWeight.w700, -1.2),
        headline = _style(fontFamily, 26, 30, FontWeight.w600, -0.8);

  final String? fontFamily;
  final TextStyle labelXs, labelSm, bodySm, bodyMd, bodyLg;
  final TextStyle titleSm, titleMd, titleLg, displaySm, displayMd;
  final TextStyle pageDisplay, headline;

  /// The Material slots Nuvio overrides; others keep Material 3 defaults.
  TextTheme toTextTheme() => TextTheme(
        displayLarge: pageDisplay,
        headlineLarge: headline,
        titleLarge: _style(fontFamily, 18, 24, FontWeight.w600),
        titleMedium: _style(fontFamily, 16, 20, FontWeight.w600),
        bodyLarge: _style(fontFamily, 15, 22, FontWeight.w400),
        bodyMedium: bodyMd,
        labelLarge: _style(fontFamily, 14, 18, FontWeight.w600),
        labelMedium: _style(fontFamily, 12, 14, FontWeight.w600, 0.8),
      );

  @override
  NuvioTypeScale copyWith({String? fontFamily}) =>
      NuvioTypeScale(fontFamily: fontFamily ?? this.fontFamily);

  @override
  NuvioTypeScale lerp(NuvioTypeScale? other, double t) =>
      other == null || t < 0.5 ? this : other;
}
