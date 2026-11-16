import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Opaque content card (NuvioSurfaceCard).
class NuvioSurfaceCard extends StatelessWidget {
  const NuvioSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(NuvioSpace.cardPadding),
    this.compact = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  /// Uses the 12 px compact-card radius instead of 24 px.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surfaceCard,
        borderRadius: NuvioRadius.all(
          compact ? NuvioRadius.compactCard : NuvioRadius.card,
        ),
        border: Border.all(color: c.borderSubtle, width: NuvioBorderWidth.thin),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

/// Translucent dark panel laid over artwork, like the stream results panel.
///
/// Nuvio uses plain translucency here; set [blur] for a frosted look.
class NuvioGlassPanel extends StatelessWidget {
  const NuvioGlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(NuvioSpace.s24),
    this.radius = NuvioRadius.playerPanel,
    this.blur = 0,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double blur;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final shape = NuvioRadius.all(radius);
    Widget panel = DecoratedBox(
      decoration: BoxDecoration(
        color: c.glassPanel,
        borderRadius: shape,
        border: Border.all(color: c.overlayHover, width: NuvioBorderWidth.thin),
      ),
      child: Padding(padding: padding, child: child),
    );
    if (blur > 0) {
      panel = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: panel,
      );
    }
    return ClipRRect(borderRadius: shape, child: panel);
  }
}

/// Tappable translucent row card, as used for each stream result
/// (StreamCard.kt): 12 px radius, white 5 % fill, accent outline when selected.
class NuvioListCard extends StatelessWidget {
  const NuvioListCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: NuvioSpace.s16,
      vertical: NuvioSpace.s12,
    ),
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool selected;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Material(
      color: selected ? c.accent.withValues(alpha: 0.12) : c.glassFill,
      shape: RoundedRectangleBorder(
        borderRadius: NuvioRadius.all(NuvioRadius.lg),
        side: selected
            ? BorderSide(color: c.accent.withValues(alpha: 0.52))
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        hoverColor: c.overlayHover,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Small uppercase-style section heading (NuvioSectionLabel).
class NuvioSectionLabel extends StatelessWidget {
  const NuvioSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: NuvioSpace.s8),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: context.nuvioColors.textMuted),
        ),
      );
}
