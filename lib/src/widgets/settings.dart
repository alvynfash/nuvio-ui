// Building blocks for settings screens.

import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Header above a group of settings: bold muted label with
/// optional trailing actions.
class NuvioSettingsSection extends StatelessWidget {
  const NuvioSettingsSection({
    super.key,
    required this.title,
    required this.child,
    this.actions = const [],
  });

  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            NuvioSpace.s4,
            0,
            NuvioSpace.s4,
            NuvioSpace.controlGap,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: c.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(mainAxisSize: MainAxisSize.min, children: actions),
            ],
          ),
        ),
        child,
      ],
    );
  }
}

/// Card that stacks rows with hairline dividers.
class NuvioSettingsGroup extends StatelessWidget {
  const NuvioSettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: NuvioRadius.all(NuvioRadius.card),
        border: Border.all(
          color: c.borderSubtle,
          width: NuvioBorderWidth.hairline,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0)
                Divider(
                  height: NuvioBorderWidth.hairline,
                  thickness: NuvioBorderWidth.hairline,
                  indent: NuvioSpace.s20,
                  endIndent: NuvioSpace.s20,
                  color: c.borderSubtle,
                ),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _RowText extends StatelessWidget {
  const _RowText(this.title, this.description, {this.enabled = true});

  final String title;
  final String? description;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final tt = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Opacity(
        opacity: enabled ? 1 : NuvioOpacity.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: tt.bodyLarge!.copyWith(
                color: c.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (description != null) ...[
              const SizedBox(height: NuvioSpace.s2),
              Text(
                description!,
                style: tt.bodyMedium!.copyWith(color: c.textMuted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

const _rowPadding = EdgeInsets.symmetric(
  horizontal: NuvioSpace.s20,
  vertical: NuvioSpace.s16,
);

/// Title, optional description and a switch; the whole row toggles
///. [locked] shows a lock and disables the row.
class NuvioSwitchRow extends StatelessWidget {
  const NuvioSwitchRow({
    super.key,
    required this.title,
    this.description,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.locked = false,
  });

  final String title;
  final String? description;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final active = enabled && !locked && onChanged != null;
    return InkWell(
      onTap: active ? () => onChanged!(!value) : null,
      child: Padding(
        padding: _rowPadding,
        child: Row(
          children: [
            Expanded(child: _RowText(title, description, enabled: enabled)),
            const SizedBox(width: NuvioSpace.s12),
            if (locked)
              Padding(
                padding: const EdgeInsets.only(right: NuvioSpace.s8),
                child: Icon(
                  Icons.lock_rounded,
                  size: NuvioIconSize.md,
                  color: context.nuvioColors.textMuted.withValues(
                    alpha: NuvioOpacity.medium,
                  ),
                ),
              ),
            Switch(value: value, onChanged: active ? onChanged : null),
          ],
        ),
      ),
    );
  }
}

/// Tappable row leading to another page.
class NuvioNavigationRow extends StatelessWidget {
  const NuvioNavigationRow({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.value,
    required this.onTap,
  });

  final String title;
  final String? description;
  final IconData? icon;

  /// Current value shown before the chevron, e.g. "English".
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: _rowPadding,
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: NuvioIconSize.lg, color: c.textSecondary),
              const SizedBox(width: NuvioSpace.s14),
            ],
            Expanded(
              child: _RowText(title, description, enabled: onTap != null),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(left: NuvioSpace.s12),
                child: Text(
                  value!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: c.textMuted),
                ),
              ),
            const SizedBox(width: NuvioSpace.s4),
            Icon(Icons.chevron_right_rounded, color: c.textMuted),
          ],
        ),
      ),
    );
  }
}

/// Labelled slider row.
class NuvioSliderRow extends StatelessWidget {
  const NuvioSliderRow({
    super.key,
    required this.title,
    this.description,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.format,
  });

  final String title;
  final String? description;
  final double value;
  final ValueChanged<double>? onChanged;
  final double min, max;
  final int? divisions;

  /// Formats the value badge, e.g. `(v) => '${v.round()} s'`.
  final String Function(double)? format;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Padding(
      padding: _rowPadding.copyWith(bottom: NuvioSpace.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _RowText(title, description, enabled: onChanged != null),
              ),
              Text(
                format?.call(value) ??
                    value.toStringAsFixed(divisions == null ? 2 : 0),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: c.accent,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// Side-navigation entry with an accent icon tile.
class NuvioSidebarItem extends StatelessWidget {
  const NuvioSidebarItem({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Material(
      color:
          selected
              ? c.accent.withValues(alpha: NuvioOpacity.hover)
              : Colors.transparent,
      borderRadius: NuvioRadius.all(NuvioSpace.s10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        hoverColor: c.overlayHover,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NuvioSpace.s10,
            vertical: NuvioSpace.s6,
          ),
          child: Row(
            children: [
              Container(
                width: NuvioIconSize.xl,
                height: NuvioIconSize.xl,
                decoration: BoxDecoration(
                  color:
                      selected
                          ? c.accent.withValues(alpha: NuvioOpacity.selected)
                          : c.overlaySelected.withValues(
                            alpha: NuvioOpacity.subtle,
                          ),
                  borderRadius: NuvioRadius.all(NuvioRadius.md),
                ),
                child: Icon(
                  icon,
                  size: NuvioIconSize.md,
                  color: selected ? c.accent : c.textMuted,
                ),
              ),
              const SizedBox(width: NuvioSpace.s12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: selected ? c.textPrimary : c.textSecondary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
