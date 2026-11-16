import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Accent-filled call to action (NuvioPrimaryButton).
class NuvioPrimaryButton extends StatelessWidget {
  const NuvioPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final style = FilledButton.styleFrom(
      minimumSize: Size(expand ? double.infinity : 0, NuvioSpace.s48),
      padding: const EdgeInsets.symmetric(horizontal: NuvioSpace.s24),
    );
    return icon == null
        ? FilledButton(onPressed: onPressed, style: style, child: Text(label))
        : FilledButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(icon, size: NuvioIconSize.md),
            label: Text(label),
          );
  }
}

/// Round translucent icon button floating over artwork, e.g. the back button
/// (NuvioBackButton / NuvioIconActionButton).
class NuvioCircleIconButton extends StatelessWidget {
  const NuvioCircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 54,
  });

  /// Back button with the platform-neutral arrow used by Nuvio.
  const NuvioCircleIconButton.back({super.key, required this.onPressed, this.size = 54})
      : icon = Icons.arrow_back,
        tooltip = 'Back';

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final button = Material(
      color: c.surfaceElevated.withValues(alpha: 0.85),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        hoverColor: c.overlayHover,
        child: SizedBox.square(
          dimension: size,
          child: Icon(icon, color: c.textPrimary, size: NuvioIconSize.lg),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
