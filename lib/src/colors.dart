// Semantic colour roles, derived from the active palette.

import 'package:flutter/material.dart';

import 'palettes.dart';

/// Semantic colour roles for the active palette, available as
/// `context.nuvioColors`.
@immutable
class NuvioColors extends ThemeExtension<NuvioColors> {
  /// Creates colour roles for [palette].
  const NuvioColors(this.palette, {this.amoled = false});

  /// The palette these roles derive from.
  final NuvioPalette palette;

  /// Pure-black backgrounds for OLED screens.
  final bool amoled;

  static const _black = Color(0xFF000000);
  static const _white = Color(0xFFFFFFFF);

  /// Page background (pure black when `amoled`).
  Color get background => amoled ? _black : palette.background;

  /// Default surface for cards and groups.
  Color get surface => palette.backgroundElevated;

  /// Raised surfaces such as app bars and banners.
  Color get surfaceElevated => palette.backgroundElevated;

  /// Card and input fill.
  Color get surfaceCard => palette.backgroundCard;

  /// Bottom-sheet background.
  Color get surfaceSheet => palette.backgroundElevated;

  /// Dialog background.
  Color get surfaceDialog => palette.backgroundElevated;

  /// Menus, toasts and tooltips.
  Color get surfacePopover => palette.backgroundCard;

  /// Window / system chrome colour.
  Color get nativeChrome => _black;

  /// Primary text and icons.
  Color get textPrimary => const Color(0xFFF5F7F8);

  /// Secondary text.
  Color get textSecondary => const Color(0xFFB8BEC5);

  /// Muted text, hints and inactive icons.
  Color get textMuted => const Color(0xFF969CA3);

  /// Disabled text.
  Color get textDisabled => const Color(0xFF969CA3).withValues(alpha: 0.38);

  /// Text on light fills.
  Color get textInverse => const Color(0xFF111111);

  /// Palette accent: primary actions, selection, progress.
  Color get accent => palette.secondary;

  /// Stronger accent variant.
  Color get accentStrong => palette.secondaryVariant;

  /// Content drawn on [accent].
  Color get onAccent => palette.onSecondary;

  /// Keyboard focus ring.
  Color get focusRing => palette.focusRing;

  /// Focused / selected item background.
  Color get focusBackground => palette.focusBackground;

  /// Accent as a gradient (multi-stop for gradient palettes).
  LinearGradient get accentGradient => palette.accentBrush;

  /// Subtle dividers and outlines.
  Color get borderSubtle => const Color(0xFF252A2A).withValues(alpha: 0.55);

  /// Default outlines.
  Color get borderDefault => const Color(0xFF252A2A);

  /// Emphasised outlines and drag handles.
  Color get borderStrong => const Color(0xFF3A4040);

  /// Focused input outline.
  Color get borderFocus => palette.focusRing;

  /// Selected chip outline.
  Color get borderSelected => palette.secondary.withValues(alpha: 0.75);

  /// Success state.
  Color get success => const Color(0xFF66BB6A);

  /// Warning state.
  Color get warning => const Color(0xFFFFC857);

  /// Errors and destructive actions.
  Color get danger => const Color(0xFFE36A8A);

  /// Content drawn on [danger].
  Color get onDanger => const Color(0xFFFCE5EC);

  /// Informational state.
  Color get info => const Color(0xFF42A5F5);

  /// Neutral state.
  Color get neutral => const Color(0xFF969CA3);

  /// Scrim behind dialogs and sheets.
  Color get overlayScrim => _black.withValues(alpha: 0.56);

  /// Hover overlay.
  Color get overlayHover => _white.withValues(alpha: 0.08);

  /// Pressed overlay.
  Color get overlayPressed => _white.withValues(alpha: 0.12);

  /// Selected overlay.
  Color get overlaySelected => _white.withValues(alpha: 0.15);

  /// Overlay for disabled areas.
  Color get overlayDisabled => _black.withValues(alpha: 0.38);

  /// Skeleton shimmer highlight.
  Color get shimmer => _white.withValues(alpha: 0.10);

  /// Skeleton placeholder fill.
  Color get skeleton => _white.withValues(alpha: 0.06);

  /// Fill of translucent list cards over artwork.
  Color get glassFill => _white.withValues(alpha: 0.05);

  /// Fill of the translucent side panel over artwork (StreamsScreen).
  Color get glassPanel => _black.withValues(alpha: 0.42);

  /// Video-player control bar background.
  Color get playerControlsBackground => _black.withValues(alpha: 0.72);

  /// Video-player control icons and text.
  Color get playerControlsForeground => _white;

  /// Unplayed part of timelines and sliders.
  Color get playerTimelineTrack => _white.withValues(alpha: 0.30);

  /// Played part of timelines.
  Color get playerTimelineFill => palette.secondary;

  /// Subtitle preview backdrop.
  Color get playerSubtitlePreview => _black.withValues(alpha: 0.55);

  /// Buffering indicator.
  Color get playerBuffering => palette.secondary;

  /// Parental-guidance badge background.
  Color get parentalGuide => const Color(0xFF5D1F1F);

  /// Top highlight on glassy surfaces (dialogs, sheets, menus).
  LinearGradient get surfaceEdge => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [_white.withValues(alpha: 0.16), _white.withValues(alpha: 0.04)],
  );

  /// Deep violet-to-black page wash.
  /// Nuvio draws it from (0,0) to (1000,1600) px; this approximates the angle.
  LinearGradient get overlayGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF21113B),
      Color(0xFF21113B),
      Color(0xFF1A0E2F),
      Color(0xFF130A23),
      Color(0xFF0A060F),
      Color(0xFF050408),
      _black,
      _black,
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
