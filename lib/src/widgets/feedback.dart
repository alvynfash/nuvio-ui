import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Thin rounded progress bar. [value] null = indeterminate.
class NuvioProgressBar extends StatelessWidget {
  const NuvioProgressBar({super.key, required this.value, this.height = 4});

  final double? value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return ClipRRect(
      borderRadius: NuvioRadius.all(NuvioRadius.full),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(end: value ?? 0.0),
        duration: NuvioMotion.normal,
        curve: NuvioMotion.standard,
        builder:
            (_, v, __) => LinearProgressIndicator(
              value: value == null ? null : v,
              minHeight: height,
              color: c.accent,
              backgroundColor: c.playerTimelineTrack,
            ),
      ),
    );
  }
}

/// Pill badge for metadata such as "4K HDR": card fill,
/// muted label. [accent] is an extra variant for highlights.
class NuvioInfoBadge extends StatelessWidget {
  const NuvioInfoBadge(this.text, {super.key, this.accent = false});

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent ? c.accent : c.surfaceCard,
        borderRadius: NuvioRadius.all(NuvioRadius.chip),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: NuvioSpace.s10,
          vertical: NuvioSpace.s6,
        ),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: accent ? c.onAccent : c.textMuted,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

/// Spinning accent arc: 40 px, round caps.
class NuvioLoadingIndicator extends StatelessWidget {
  const NuvioLoadingIndicator({
    super.key,
    this.size = NuvioSpace.s40,
    this.color,
  });

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CircularProgressIndicator(
      strokeWidth: size * 0.09,
      strokeCap: StrokeCap.round,
      color: color ?? context.nuvioColors.accent,
    ),
  );
}

/// Empty/error state card with a call to action.
class NuvioEmptyState extends StatelessWidget {
  const NuvioEmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final tt = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: NuvioRadius.all(NuvioRadius.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(NuvioSpace.cardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, size: NuvioIconSize.xl, color: c.textMuted),
              const SizedBox(height: NuvioSpace.s12),
            ],
            Text(title, style: tt.titleLarge!.copyWith(color: c.textPrimary)),
            const SizedBox(height: NuvioSpace.controlGap),
            Text(message, style: tt.bodyLarge!.copyWith(color: c.textMuted)),
            if (actionLabel != null) ...[
              const SizedBox(height: NuvioSpace.screenHorizontal),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, NuvioSpace.s48 + NuvioSpace.s4),
                  ),
                  child: Text(actionLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Floating "continue watching" card: poster, title,
/// progress and a round play button. Slides in when [visible] turns true.
class NuvioResumePrompt extends StatelessWidget {
  const NuvioResumePrompt({
    super.key,
    required this.visible,
    required this.title,
    this.eyebrow = 'Continue watching',
    this.subtitle,
    this.progress,
    this.poster,
    required this.onPlay,
    this.onDismiss,
  });

  final bool visible;
  final String eyebrow;
  final String title;
  final String? subtitle;

  /// 0..1 playback progress; null hides the bar.
  final double? progress;

  /// Poster image; a card-coloured placeholder is shown when null.
  final ImageProvider? poster;
  final VoidCallback onPlay;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final tt = Theme.of(context).textTheme;
    return AnimatedSlide(
      offset: visible ? Offset.zero : const Offset(0, 1.2),
      duration: NuvioMotion.slow,
      curve: NuvioMotion.emphasized,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: NuvioMotion.normal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: NuvioComponent.sheetMaxWidth,
          ),
          child: Material(
            color: c.surfacePopover,
            elevation: NuvioElevation.modal,
            shadowColor: Colors.black,
            borderRadius: NuvioRadius.all(NuvioRadius.card),
            child: Padding(
              padding: const EdgeInsets.all(NuvioSpace.cardPaddingCompact),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: NuvioRadius.all(NuvioRadius.compactCard),
                    child: Container(
                      width: NuvioSpace.s56 - NuvioSpace.s2,
                      height: NuvioSpace.s80 - NuvioSpace.s2,
                      color: c.surfaceCard,
                      child:
                          poster == null
                              ? Icon(Icons.movie_outlined, color: c.textMuted)
                              : Image(image: poster!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: NuvioSpace.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eyebrow,
                          style: t.labelSm.copyWith(color: c.textMuted),
                        ),
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tt.bodyLarge!.copyWith(
                            color: c.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: t.bodySm.copyWith(color: c.textMuted),
                          ),
                        if (progress != null) ...[
                          const SizedBox(height: NuvioSpace.s8),
                          ClipRRect(
                            borderRadius: NuvioRadius.all(NuvioRadius.full),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: NuvioSpace.s6,
                              color: c.playerTimelineFill,
                              backgroundColor: c.playerTimelineTrack,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: NuvioSpace.s12),
                  IconButton.filled(
                    onPressed: onPlay,
                    iconSize: NuvioIconSize.md,
                    style: IconButton.styleFrom(
                      backgroundColor: c.accent,
                      foregroundColor: c.onAccent,
                      fixedSize: const Size.square(
                        NuvioSpace.s40 + NuvioSpace.s2,
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow_rounded),
                  ),
                  if (onDismiss != null)
                    IconButton(
                      onPressed: onDismiss,
                      color: c.textMuted,
                      icon: const Icon(Icons.close_rounded),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Full-width status strip with icon, two lines of text and optional progress,
/// like Nuvio's in-app update banner ("0.1.36-alpha • 170 MB / Downloading 78%").
class NuvioStatusBanner extends StatelessWidget {
  const NuvioStatusBanner({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.progress,
    this.actions = const [],
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  /// 0..1 fills the banner background behind the content; null shows none.
  final double? progress;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final type = context.nuvioType;
    return Material(
      color: c.surfaceElevated,
      child: Stack(
        children: [
          if (progress != null)
            Positioned.fill(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: progress!.clamp(0.0, 1.0)),
                duration: NuvioMotion.normal,
                builder:
                    (_, v, __) => FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: v,
                      child: ColoredBox(color: c.overlaySelected),
                    ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: NuvioSpace.s16,
              vertical: NuvioSpace.s12,
            ),
            child: Row(
              children: [
                Icon(icon, color: c.textPrimary, size: NuvioIconSize.lg),
                const SizedBox(width: NuvioSpace.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: type.titleSm.copyWith(color: c.textPrimary),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: type.bodySm.copyWith(color: c.textSecondary),
                        ),
                    ],
                  ),
                ),
                ...actions,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Placeholder block with a shimmer sweep, shown while content loads.
class NuvioSkeleton extends StatefulWidget {
  const NuvioSkeleton({
    super.key,
    this.width,
    this.height,
    this.radius = NuvioRadius.poster,
  });

  final double? width;
  final double? height;
  final double radius;

  @override
  State<NuvioSkeleton> createState() => _NuvioSkeletonState();
}

class _NuvioSkeletonState extends State<NuvioSkeleton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final t = _controller.value * 3 - 1; // sweep from -1 to 2
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: NuvioRadius.all(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(t - 1, 0),
              end: Alignment(t + 1, 0),
              colors: [c.skeleton, c.shimmer, c.skeleton],
            ),
          ),
        );
      },
    );
  }
}
