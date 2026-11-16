import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'colors.dart';
import 'palettes.dart';
import 'tokens.dart';
import 'typography.dart';

abstract final class NuvioThemeData {
  /// Dark Material 3 theme with Nuvio's colour scheme, typography and
  /// component defaults. Nuvio is dark-only, so there is no light variant.
  ///
  /// [fontFamily] defaults to the bundled JetBrains Sans. Pass the name of a
  /// font your app bundles to override it, or `null` for the platform font.
  static ThemeData build(
    NuvioPalette palette, {
    bool amoled = false,
    String? fontFamily = NuvioFonts.defaultFamily,
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
    final tt = type.toTextTheme();
    WidgetStateProperty<Color?> selectedOr(Color on, Color off) =>
        WidgetStateProperty.resolveWith((s) {
          final color = s.contains(WidgetState.selected) ? on : off;
          return s.contains(WidgetState.disabled)
              ? color.withValues(alpha: color.a * NuvioOpacity.disabled)
              : color;
        });
    final menuShape = RoundedRectangleBorder(
      borderRadius: NuvioRadius.all(NuvioSpace.s20),
      side: BorderSide(color: Colors.white.withValues(alpha: 0.10)),
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
        constraints: const BoxConstraints(
          maxWidth: NuvioComponent.sheetMaxWidth,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(NuvioRadius.sheet),
          ),
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
        style: TextButton.styleFrom(
          foregroundColor: c.accent,
          shape: buttonShape,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceCard,
        hintStyle: tt.bodyLarge!.copyWith(color: c.textMuted),
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
          borderSide: BorderSide(color: c.borderFocus),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.accent,
        linearTrackColor: c.playerTimelineTrack,
      ),
      // Accent track + onAccent thumb when on; muted thumb on
      // the default border colour when off.
      switchTheme: SwitchThemeData(
        thumbColor: selectedOr(c.onAccent, c.textMuted),
        trackColor: selectedOr(c.accent, c.borderDefault),
        trackOutlineColor: selectedOr(c.accent, c.borderStrong),
      ),
      // Not used by Nuvio (it has no checkboxes); styled to match radios.
      checkboxTheme: CheckboxThemeData(
        fillColor: selectedOr(c.accent, Colors.transparent),
        checkColor: WidgetStatePropertyAll(c.onAccent),
        side: BorderSide(color: c.textMuted, width: NuvioBorderWidth.medium),
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.xs),
        ),
      ),
      radioTheme: RadioThemeData(fillColor: selectedOr(c.accent, c.textMuted)),
      // 4 px track, accent-gradient fill, 20 px round thumb.
      sliderTheme: SliderThemeData(
        trackHeight: NuvioSpace.s4,
        activeTrackColor: c.accent,
        inactiveTrackColor: c.playerTimelineTrack,
        thumbColor: c.textPrimary,
        overlayColor: c.accent.withValues(alpha: NuvioOpacity.selected),
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: NuvioSpace.s10,
        ),
        trackShape: NuvioGradientSliderTrack(palette.accentBrush),
        valueIndicatorColor: c.surfacePopover,
        valueIndicatorTextStyle: type.labelSm.copyWith(color: c.textPrimary),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: c.textPrimary,
        unselectedLabelColor: c.textMuted,
        indicatorColor: c.accent,
        dividerColor: c.borderSubtle,
        labelStyle: tt.labelLarge,
        unselectedLabelStyle: tt.labelLarge,
        overlayColor: WidgetStatePropertyAll(c.overlayHover),
      ),
      // 180 px min width, 20 px radius, edge outline.
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(c.surfacePopover),
          shape: WidgetStatePropertyAll(menuShape),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(NuvioSpace.s8)),
          minimumSize: const WidgetStatePropertyAll(Size(180, 0)),
          elevation: const WidgetStatePropertyAll(NuvioElevation.modal),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(c.textPrimary),
          iconColor: WidgetStatePropertyAll(c.textMuted),
          overlayColor: WidgetStatePropertyAll(
            c.accent.withValues(alpha: NuvioOpacity.hover),
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(NuvioSpace.s12)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            tt.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.surfacePopover,
        shape: menuShape,
        textStyle: tt.bodyLarge!.copyWith(
          color: c.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: c.surfacePopover,
          borderRadius: NuvioRadius.all(NuvioRadius.md),
          border: Border.all(color: c.borderDefault),
        ),
        textStyle: type.bodySm.copyWith(color: c.textPrimary),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.textMuted,
        textColor: c.textPrimary,
        selectedColor: c.accent,
        selectedTileColor: c.accent.withValues(alpha: NuvioOpacity.hover),
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.accent,
        selectionColor: c.accent.withValues(alpha: NuvioOpacity.overlayLight),
        selectionHandleColor: c.accent,
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

  /// Whole-UI scale Nuvio uses on desktop:
  /// clamp(min(w / 1280, h / 820), 1.0, 1.18).
  static double desktopUiScale(Size window) {
    if (window.width <= 0 || window.height <= 0) return 1;
    final s = math.min(window.width / 1280, window.height / 820);
    return s.clamp(1.0, 1.18);
  }

  /// Extra text scale Nuvio applies on desktop.
  static const double desktopFontScale = 1.08;
}

Color _contentColorFor(Color c) =>
    c.computeLuminance() > 0.5
        ? const Color(0xFF111111)
        : const Color(0xFFF5F7F8);

extension NuvioThemeContext on BuildContext {
  NuvioColors get nuvioColors => Theme.of(this).extension<NuvioColors>()!;
  NuvioTypeScale get nuvioType => Theme.of(this).extension<NuvioTypeScale>()!;
}

/// Slider track that fills the active part with the palette's accent
/// gradient, as Nuvio's custom Slider does.
class NuvioGradientSliderTrack extends SliderTrackShape
    with BaseSliderTrackShape {
  const NuvioGradientSliderTrack(this.gradient);

  final Gradient gradient;

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
    required TextDirection textDirection,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final radius = Radius.circular(rect.height / 2);
    final canvas = context.canvas;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, radius),
      Paint()
        ..color = sliderTheme.inactiveTrackColor ?? const Color(0x4DFFFFFF),
    );
    final ltr = textDirection == TextDirection.ltr;
    final active =
        ltr
            ? Rect.fromLTRB(rect.left, rect.top, thumbCenter.dx, rect.bottom)
            : Rect.fromLTRB(thumbCenter.dx, rect.top, rect.right, rect.bottom);
    if (active.width <= 0) return;
    final paint = Paint()..shader = gradient.createShader(rect);
    if (!isEnabled) {
      paint.colorFilter = ColorFilter.mode(
        Colors.white.withValues(alpha: NuvioOpacity.disabled),
        BlendMode.modulate,
      );
    }
    canvas.drawRRect(RRect.fromRectAndRadius(active, radius), paint);
  }
}
