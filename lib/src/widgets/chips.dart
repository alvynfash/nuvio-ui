import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Outlined selectable chip: 8 px radius, thin border,
/// white 15 % fill when selected.
class NuvioChip extends StatelessWidget {
  const NuvioChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final radius = NuvioRadius.all(NuvioRadius.md);
    final fg =
        !enabled
            ? c.textDisabled
            : selected
            ? c.textPrimary
            : c.textMuted;
    return Material(
      color: selected ? c.overlaySelected : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: selected ? c.borderSelected : c.borderDefault,
          width: NuvioBorderWidth.thin,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onTap : null,
        hoverColor: c.overlayHover,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NuvioSpace.s12,
            vertical: NuvioSpace.s8,
          ),
          child: Text(
            label,
            style: context.nuvioType.labelSm.copyWith(color: fg),
          ),
        ),
      ),
    );
  }
}

/// Pill-shaped filter toggle, as in the provider row above stream results
/// 36 px tall, accent fill when selected, shrinks to
/// 96 % while pressed.
class NuvioFilterPill extends StatelessWidget {
  const NuvioFilterPill({
    super.key,
    this.label,
    this.icon,
    required this.selected,
    required this.onTap,
  }) : assert(label != null || icon != null);

  final String? label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final fg = selected ? c.onAccent : c.textPrimary;
    final text = Theme.of(context).textTheme.labelMedium!.copyWith(
      color: fg,
      letterSpacing: 0,
      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
    );
    return NuvioPressScale(
      child: Material(
        color: selected ? c.accent : c.surfaceCard.withValues(alpha: 0.6),
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: NuvioComponent.filterPillHeight,
              minHeight: NuvioComponent.filterPillHeight,
              maxHeight: NuvioComponent.filterPillHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: label == null ? 0 : NuvioSpace.s16,
              ),
              // widthFactor 1 makes the pill hug its content instead of
              // stretching to the available width.
              child: Center(
                widthFactor: 1,
                child:
                    label == null
                        ? Icon(icon, size: NuvioIconSize.md, color: fg)
                        : Text(label!, style: text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Scales its child down slightly while a pointer is pressed on it.
///
/// The only stateful helper in the package; everything else is stateless, so
/// the package works the same in plain, hooks or Riverpod apps.
class NuvioPressScale extends StatefulWidget {
  const NuvioPressScale({super.key, required this.child, this.scale = 0.96});

  final Widget child;
  final double scale;

  @override
  State<NuvioPressScale> createState() => _NuvioPressScaleState();
}

class _NuvioPressScaleState extends State<NuvioPressScale> {
  bool _pressed = false;

  void _set(bool v) {
    if (_pressed != v) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (_) => _set(true),
    onPointerUp: (_) => _set(false),
    onPointerCancel: (_) => _set(false),
    child: AnimatedScale(
      scale: _pressed ? widget.scale : 1,
      duration: NuvioMotion.fast,
      curve: NuvioMotion.standard,
      child: widget.child,
    ),
  );
}
