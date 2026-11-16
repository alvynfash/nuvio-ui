// Semantic colours (NuvioColorTokens, as built by defaultNuvioThemeTokens).

import 'package:flutter/material.dart';

import 'palettes.dart';

@immutable
class NuvioColors extends ThemeExtension<NuvioColors> {
  const NuvioColors(this.palette, {this.amoled = false});

  final NuvioPalette palette;

  /// Pure-black backgrounds for OLED screens.
  final bool amoled;

  static const _black = Color(0xFF000000);
  static const _white = Color(0xFFFFFFFF);

  Color get background => amoled ? _black : palette.background;
  Color get surface => palette.backgroundElevated;
  Color get surfaceElevated => palette.backgroundElevated;
  Color get surfaceCard => palette.backgroundCard;
  Color get surfaceSheet => palette.backgroundElevated;
  Color get surfaceDialog => palette.backgroundElevated;
  Color get surfacePopover => palette.backgroundCard;
  Color get nativeChrome => _black;

  Color get textPrimary => const Color(0xFFF5F7F8);
  Color get textSecondary => const Color(0xFFB8BEC5);
  Color get textMuted => const Color(0xFF969CA3);
  Color get textDisabled => const Color(0xFF969CA3).withValues(alpha: 0.38);
  Color get textInverse => const Color(0xFF111111);

  Color get accent => palette.secondary;
  Color get accentStrong => palette.secondaryVariant;
  Color get onAccent => palette.onSecondary;
  Color get focusRing => palette.focusRing;
  Color get focusBackground => palette.focusBackground;
  LinearGradient get accentGradient => palette.accentBrush;

  Color get borderSubtle => const Color(0xFF252A2A).withValues(alpha: 0.55);
  Color get borderDefault => const Color(0xFF252A2A);
  Color get borderStrong => const Color(0xFF3A4040);
  Color get borderFocus => palette.focusRing;
  Color get borderSelected => palette.secondary.withValues(alpha: 0.75);

  Color get success => const Color(0xFF66BB6A);
  Color get warning => const Color(0xFFFFC857);
  Color get danger => const Color(0xFFE36A8A);
  Color get onDanger => const Color(0xFFFCE5EC);
  Color get info => const Color(0xFF42A5F5);
  Color get neutral => const Color(0xFF969CA3);

  Color get overlayScrim => _black.withValues(alpha: 0.56);
  Color get overlayHover => _white.withValues(alpha: 0.08);
  Color get overlayPressed => _white.withValues(alpha: 0.12);
  Color get overlaySelected => _white.withValues(alpha: 0.15);
  Color get overlayDisabled => _black.withValues(alpha: 0.38);
  Color get shimmer => _white.withValues(alpha: 0.10);
  Color get skeleton => _white.withValues(alpha: 0.06);

  /// Fill of translucent list cards over artwork (StreamCard).
  Color get glassFill => _white.withValues(alpha: 0.05);

  /// Fill of the translucent side panel over artwork (StreamsScreen).
  Color get glassPanel => _black.withValues(alpha: 0.42);

  Color get playerControlsBackground => _black.withValues(alpha: 0.72);
  Color get playerControlsForeground => _white;
  Color get playerTimelineTrack => _white.withValues(alpha: 0.30);
  Color get playerTimelineFill => palette.secondary;
  Color get playerSubtitlePreview => _black.withValues(alpha: 0.55);
  Color get playerBuffering => palette.secondary;
  Color get parentalGuide => const Color(0xFF5D1F1F);

  /// GradientsKt.SurfaceEdge: top highlight on glassy surfaces.
  LinearGradient get surfaceEdge => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [_white.withValues(alpha: 0.16), _white.withValues(alpha: 0.04)],
      );

  /// GradientsKt.nuvioOverlayGradientBrush: deep violet-to-black page wash.
  /// Nuvio draws it from (0,0) to (1000,1600) px; this approximates the angle.
  LinearGradient get overlayGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF21113B), Color(0xFF21113B), Color(0xFF1A0E2F),
          Color(0xFF130A23), Color(0xFF0A060F), Color(0xFF050408),
          _black, _black,
        ],
        stops: [0, 0.12, 0.24, 0.34, 0.44, 0.58, 0.64, 1],
      );

  @override
  NuvioColors copyWith({NuvioPalette? palette, bool? amoled}) =>
      NuvioColors(palette ?? this.palette, amoled: amoled ?? this.amoled);

  // Palettes are discrete choices, so snap rather than interpolate.
  @override
  NuvioColors lerp(NuvioColors? other, double t) =>
      other == null || t < 0.5 ? this : other;
}
