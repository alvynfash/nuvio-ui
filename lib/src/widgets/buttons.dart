import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Accent-filled call to action: 52 px tall, 16 px
/// radius. Nuvio always stretches it to full width; pass [expand] for that.
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
      minimumSize: Size(
        expand ? double.infinity : 0,
        NuvioSpace.s48 + NuvioSpace.s4,
      ),
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

/// Round icon button. [filled] gives the translucent disc used over artwork
/// (streams screen, surface at 72 %); unfilled matches NuvioBackButton
/// (40 px, transparent).
class NuvioCircleIconButton extends StatelessWidget {
  const NuvioCircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 54,
    this.filled = true,
  });

  /// Back button with the rounded arrow used by Nuvio.
  const NuvioCircleIconButton.back({
    super.key,
    required this.onPressed,
    this.size = 54,
    this.filled = true,
  }) : icon = Icons.arrow_back_rounded,
       tooltip = 'Back';

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final button = Material(
      color:
          filled
              ? c.surfaceElevated.withValues(alpha: 0.72)
              : Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        hoverColor: c.overlayHover,
        child: SizedBox.square(
          dimension: size,
          child: Icon(
            icon,
            color: c.textPrimary,
            size: filled ? NuvioIconSize.lg : NuvioIconSize.md,
          ),
        ),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}

/// Accent text link, e.g. "See all".
class NuvioActionLabel extends StatelessWidget {
  const NuvioActionLabel(this.text, {super.key, required this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: NuvioRadius.all(NuvioRadius.sm),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: NuvioSpace.s4,
        vertical: NuvioSpace.s2,
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: context.nuvioColors.accent),
      ),
    ),
  );
}
