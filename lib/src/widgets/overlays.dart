// Dialogs, bottom sheets, menus, dropdowns and toasts

import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Rounded box with Nuvio's 1 px gradient "surface edge" outline.
class NuvioEdgeOutlined extends StatelessWidget {
  const NuvioEdgeOutlined({
    super.key,
    required this.radius,
    required this.color,
    required this.child,
  });

  final double radius;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: context.nuvioColors.surfaceEdge,
      borderRadius: NuvioRadius.all(radius),
    ),
    child: Padding(
      padding: const EdgeInsets.all(NuvioBorderWidth.thin),
      child: ClipRRect(
        borderRadius: NuvioRadius.all(radius - NuvioBorderWidth.thin),
        child: ColoredBox(color: color, child: child),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Dialogs
// ---------------------------------------------------------------------------

enum NuvioDialogButtonStyle { primary, secondary, destructive }

/// Full-height (48 px) flat dialog action.
class NuvioDialogButton extends StatelessWidget {
  const NuvioDialogButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = NuvioDialogButtonStyle.secondary,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final NuvioDialogButtonStyle style;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final (bg, fg) = switch (style) {
      NuvioDialogButtonStyle.primary => (c.accent, c.onAccent),
      NuvioDialogButtonStyle.secondary => (
        c.textPrimary.withValues(alpha: NuvioOpacity.hover),
        c.textPrimary,
      ),
      NuvioDialogButtonStyle.destructive => (c.danger, c.textPrimary),
    };
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor: bg.withValues(
          alpha: bg.a * NuvioOpacity.disabled,
        ),
        disabledForegroundColor: fg.withValues(alpha: NuvioOpacity.disabled),
        minimumSize: const Size(0, NuvioSpace.s48),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: NuvioRadius.all(NuvioRadius.button),
        ),
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: NuvioIconSize.sm),
            const SizedBox(width: NuvioSpace.s8),
          ],
          Flexible(
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

/// Dialog panel: 460 px max width, 28 px radius, gradient edge.
/// Buttons in [actions] share the width equally.
class NuvioDialog extends StatelessWidget {
  const NuvioDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.actions = const [],
  });

  final String title;
  final String? message;
  final Widget? content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final tt = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(NuvioSpace.s24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: NuvioComponent.dialogMaxWidth,
        ),
        child: NuvioEdgeOutlined(
          radius: NuvioRadius.dialog,
          color: c.surfaceDialog,
          child: Padding(
            padding: const EdgeInsets.all(NuvioSpace.dialogPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: tt.titleLarge!.copyWith(color: c.textPrimary),
                ),
                if (message != null) ...[
                  const SizedBox(height: NuvioSpace.s8),
                  Text(
                    message!,
                    style: tt.bodyMedium!.copyWith(color: c.textSecondary),
                  ),
                ],
                if (content != null) ...[
                  const SizedBox(height: NuvioSpace.s16),
                  Flexible(child: content!),
                ],
                if (actions.isNotEmpty) ...[
                  const SizedBox(height: NuvioSpace.s20),
                  Row(
                    children: [
                      for (var i = 0; i < actions.length; i++) ...[
                        if (i > 0) const SizedBox(width: NuvioSpace.s8),
                        Expanded(child: actions[i]),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a dialog over Nuvio's scrim.
Future<T?> showNuvioDialog<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) => showDialog<T>(
  context: context,
  barrierColor: context.nuvioColors.overlayScrim,
  builder: builder,
);

/// Single-choice row used inside dialogs and sheets: accent
/// tint and check mark when selected.
class NuvioOptionTile extends StatelessWidget {
  const NuvioOptionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final tt = Theme.of(context).textTheme;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: Material(
        color:
            selected
                ? c.accent.withValues(alpha: NuvioOpacity.selected)
                : Colors.transparent,
        borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          hoverColor: c.overlayHover,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: NuvioSpace.s14,
              vertical: NuvioSpace.s12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: tt.bodyLarge!.copyWith(
                          color: c.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: t.bodySm.copyWith(color: c.textMuted),
                        ),
                    ],
                  ),
                ),
                if (selected)
                  Icon(
                    Icons.check_rounded,
                    size: NuvioIconSize.md,
                    color: c.accent,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom sheets
// ---------------------------------------------------------------------------

/// Modal sheet inset 10 px from the screen edges with a 28 px radius, gradient
/// edge and drag handle.
Future<T?> showNuvioBottomSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  String? title,
}) {
  final c = context.nuvioColors;
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: c.overlayScrim,
    elevation: 0,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: NuvioComponent.sheetMaxWidth),
    builder: (ctx) {
      final cc = ctx.nuvioColors;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(NuvioSpace.s10),
          child: NuvioEdgeOutlined(
            radius: NuvioSpace.s28,
            color: cc.surfaceSheet,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: NuvioSpace.s36,
                    height: NuvioSpace.s4,
                    margin: const EdgeInsets.only(
                      top: NuvioSpace.s10,
                      bottom: NuvioSpace.s4,
                    ),
                    decoration: BoxDecoration(
                      color: cc.borderStrong,
                      borderRadius: NuvioRadius.all(NuvioRadius.full),
                    ),
                  ),
                ),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NuvioSpace.screenHorizontal,
                      vertical: NuvioSpace.s14,
                    ),
                    child: Text(
                      title,
                      style: Theme.of(
                        ctx,
                      ).textTheme.titleLarge!.copyWith(color: cc.textPrimary),
                    ),
                  ),
                Flexible(child: builder(ctx)),
                const SizedBox(height: NuvioSpace.s8),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Sheet action with an accent icon tile.
class NuvioSheetActionRow extends StatelessWidget {
  const NuvioSheetActionRow({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: NuvioSpace.s8),
      child: Material(
        color: Colors.transparent,
        borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          hoverColor: c.accent.withValues(alpha: NuvioOpacity.hover),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: NuvioSpace.s56),
            child: Padding(
              padding: const EdgeInsets.all(NuvioSpace.s8),
              child: Row(
                children: [
                  Container(
                    width: NuvioSpace.s36,
                    height: NuvioSpace.s36,
                    decoration: BoxDecoration(
                      color: c.accent.withValues(alpha: NuvioOpacity.selected),
                      borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
                    ),
                    child: Icon(icon, size: NuvioIconSize.md, color: c.accent),
                  ),
                  const SizedBox(width: NuvioSpace.s12),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: c.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Inset divider for sheets.
class NuvioSheetDivider extends StatelessWidget {
  const NuvioSheetDivider({super.key});

  @override
  Widget build(BuildContext context) => const Divider(
    indent: NuvioSpace.screenHorizontal,
    endIndent: NuvioSpace.screenHorizontal,
    height: NuvioSpace.s8,
  );
}

// ---------------------------------------------------------------------------
// Menus and dropdowns (built on Flutter's MenuAnchor, styled by the theme)
// ---------------------------------------------------------------------------

/// Menu entry: 15 px semibold label, accent check when selected.
/// Use inside `MenuAnchor.menuChildren`; the menu closes on tap.
class NuvioMenuItem extends StatelessWidget {
  const NuvioMenuItem({
    super.key,
    required this.label,
    required this.onPressed,
    this.selected = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool selected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => MenuItemButton(
    onPressed: onPressed,
    leadingIcon: icon == null ? null : Icon(icon, size: NuvioIconSize.md),
    trailingIcon:
        selected
            ? Icon(
              Icons.check_rounded,
              size: NuvioIconSize.md,
              color: context.nuvioColors.accent,
            )
            : null,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120, maxWidth: 300),
      child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    ),
  );
}

@immutable
class NuvioDropdownOption<T> {
  const NuvioDropdownOption(this.value, this.label);

  final T value;
  final String label;
}

/// Compact select: shows the current choice and opens a
/// menu of [options].
class NuvioDropdownChip<T> extends StatelessWidget {
  const NuvioDropdownChip({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.label,
    this.placeholder = 'Select',
    this.enabled = true,
  });

  final T? value;
  final List<NuvioDropdownOption<T>> options;
  final ValueChanged<T> onChanged;

  /// Optional muted prefix, e.g. "Sort".
  final String? label;
  final String placeholder;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final tt = Theme.of(context).textTheme;
    final current = options.where((o) => o.value == value).firstOrNull;
    return MenuAnchor(
      menuChildren: [
        for (final o in options)
          NuvioMenuItem(
            label: o.label,
            selected: o.value == value,
            onPressed: () => onChanged(o.value),
          ),
      ],
      builder:
          (context, controller, _) => Material(
            color: c.surface,
            borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap:
                  enabled
                      ? () =>
                          controller.isOpen
                              ? controller.close()
                              : controller.open()
                      : null,
              hoverColor: c.overlayHover,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: NuvioSpace.s12,
                  vertical: NuvioComponent.chipVerticalPadding,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (label != null) ...[
                      Text(
                        label!,
                        style: tt.labelLarge!.copyWith(color: c.textMuted),
                      ),
                      const SizedBox(width: NuvioSpace.s6),
                    ],
                    Flexible(
                      child: Text(
                        current?.label ?? placeholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tt.labelLarge!.copyWith(
                          color: enabled ? c.textPrimary : c.textDisabled,
                        ),
                      ),
                    ),
                    const SizedBox(width: NuvioSpace.s4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: NuvioIconSize.sm + NuvioSpace.s2,
                      color: c.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}

// ---------------------------------------------------------------------------
// Toasts
// ---------------------------------------------------------------------------

/// Bottom toast: 16 px radius popover surface, 2.5 s by default, fades and
/// slides in. Only one toast shows at a time; a new one replaces the old.
abstract final class NuvioToast {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _current?.remove();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (_) => _ToastView(
            message: message,
            duration: duration,
            onDone: () {
              if (_current == entry) _current = null;
              if (entry.mounted) entry.remove();
            },
          ),
    );
    _current = entry;
    overlay.insert(entry);
  }
}

class _ToastView extends StatefulWidget {
  const _ToastView({
    required this.message,
    required this.duration,
    required this.onDone,
  });

  final String message;
  final Duration duration;
  final VoidCallback onDone;

  @override
  State<_ToastView> createState() => _ToastViewState();
}

class _ToastViewState extends State<_ToastView>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: NuvioMotion.normal,
  );

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    await _controller.forward();
    await Future<void>.delayed(widget.duration);
    if (!mounted) return;
    await _controller.reverse();
    if (mounted) widget.onDone();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final curve = CurvedAnimation(
      parent: _controller,
      curve: NuvioMotion.standard,
    );
    return Positioned(
      left: NuvioSpace.screenHorizontal,
      right: NuvioSpace.screenHorizontal,
      bottom: MediaQuery.viewPaddingOf(context).bottom + NuvioSpace.listGap,
      child: IgnorePointer(
        child: FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.4),
              end: Offset.zero,
            ).animate(curve),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: NuvioComponent.sheetMaxWidth,
                ),
                child: Material(
                  color: c.surfacePopover,
                  elevation: NuvioElevation.overlay,
                  shadowColor: Colors.black,
                  borderRadius: NuvioRadius.all(NuvioRadius.xl),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: NuvioSpace.s16,
                      vertical: NuvioSpace.s12,
                    ),
                    child: Text(
                      widget.message,
                      style: context.nuvioType.bodyMd.copyWith(
                        color: c.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
