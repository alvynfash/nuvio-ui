import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'colors.dart';
import 'palettes.dart';
import 'tokens.dart';
import 'typography.dart';

abstract final class NuvioThemeData {
  /// Dark Material 3 theme mirroring Nuvio's ThemeKt.buildColorScheme and
  /// component defaults. Nuvio is dark-only, so there is no light variant.
  ///
  /// [fontFamily] should name a font your app bundles. Nuvio ships JetBrains
  /// Sans, which is not openly licensed; Inter is a close, free substitute.
  static ThemeData build(
    NuvioPalette palette, {
    bool amoled = false,
    String? fontFamily,
  }) {
    final c = NuvioColors(palette, amoled: amoled);
    final type = NuvioTypeScale(fontFamily: fontFamily);

    final scheme = ColorScheme.dark(
      primary: palette.secondary,
      onPrimary: palette.onSecondary,
      primaryContainer: palette.focusBackground,
      onPrimaryContainer: _contentColorFor(palette.focusBackground),
      secondary: palette.secondaryVariant,
      onSecondary: palette.onSecondaryVariant,
      surface: palette.backgroundElevated,
      onSurface: c.textPrimary,
      surfaceContainerHighest: palette.backgroundCard,
      onSurfaceVariant: c.textMuted,
      error: c.danger,
      onError: c.onDanger,
      outline: c.borderDefault,
      outlineVariant: c.borderSubtle,
      scrim: c.overlayScrim,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: NuvioRadius.all(NuvioRadius.button),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      fontFamily: fontFamily,
      textTheme: type.toTextTheme(),
      extensions: [c, type],
      hoverColor: c.overlayHover,
      highlightColor: c.overlayPressed,
      focusColor: c.focusBackground,
      dividerTheme: DividerThemeData(
        color: c.borderSubtle,
        thickness: NuvioBorderWidth.thin,
      ),
      cardTheme: CardThemeData(
        color: c.surfaceCard,
        elevation: NuvioElevation.flat,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.card),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surfaceDialog,
        elevation: NuvioElevation.modal,
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.dialog),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surfaceSheet,
        modalBarrierColor: c.overlayScrim,
        constraints: const BoxConstraints(maxWidth: NuvioComponent.sheetMaxWidth),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(NuvioRadius.sheet),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.surfacePopover,
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.lg),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        selectedColor: c.overlaySelected,
        labelStyle: type.labelSm.copyWith(color: c.textMuted),
        secondaryLabelStyle: type.labelSm.copyWith(color: c.textPrimary),
        padding: const EdgeInsets.symmetric(
          horizontal: NuvioComponent.chipHorizontalPadding,
          vertical: NuvioComponent.chipVerticalPadding,
        ),
        side: BorderSide(color: c.borderDefault),
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.md),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: c.onAccent,
          shape: buttonShape,
          textStyle: type.toTextTheme().labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.textPrimary,
          side: BorderSide(color: c.borderStrong),
          shape: buttonShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: c.accent, shape: buttonShape),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceCard,
        hintStyle: type.bodyMd.copyWith(color: c.textMuted),
        border: OutlineInputBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.lg),
          borderSide: BorderSide(color: c.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.lg),
          borderSide: BorderSide(color: c.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.lg),
          borderSide: BorderSide(color: c.borderFocus, width: NuvioBorderWidth.medium),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.accent,
        linearTrackColor: c.playerTimelineTrack,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: c.surfacePopover,
        contentTextStyle: type.bodyMd.copyWith(color: c.textPrimary),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.lg),
        ),
      ),
    );
  }

  /// ThemeKt.desktopUiScaleForWindow: on desktop Nuvio scales the whole UI by
  /// clamp(min(w / 1280, h / 820), 1.0, 1.18).
  static double desktopUiScale(Size window) {
    if (window.width <= 0 || window.height <= 0) return 1;
    final s = math.min(window.width / 1280, window.height / 820);
    return s.clamp(1.0, 1.18);
  }

  /// Extra text scale Nuvio applies on desktop (NuvioDesktopFontScale).
  static const double desktopFontScale = 1.08;
}

Color _contentColorFor(Color c) => c.computeLuminance() > 0.5
    ? const Color(0xFF111111)
    : const Color(0xFFF5F7F8);

extension NuvioThemeContext on BuildContext {
  NuvioColors get nuvioColors => Theme.of(this).extension<NuvioColors>()!;
  NuvioTypeScale get nuvioType => Theme.of(this).extension<NuvioTypeScale>()!;
}
