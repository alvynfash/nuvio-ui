import 'package:flutter/material.dart';

import '../theme.dart';
import '../tokens.dart';

/// Thin rounded progress bar (NuvioProgressBar). [value] null = indeterminate.
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
        builder: (_, v, __) => LinearProgressIndicator(
          value: value == null ? null : v,
          minHeight: height,
          color: c.accent,
          backgroundColor: c.playerTimelineTrack,
        ),
      ),
    );
  }
}

/// Compact pill badge for metadata such as "4K HDR" (NuvioInfoBadge).
class NuvioInfoBadge extends StatelessWidget {
  const NuvioInfoBadge(this.text, {super.key, this.accent = false});

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent ? c.accent : c.overlaySelected,
        borderRadius: NuvioRadius.all(NuvioRadius.sm),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: NuvioSpace.s8,
          vertical: NuvioSpace.s2,
        ),
        child: Text(
          text,
          style: context.nuvioType.labelXs.copyWith(
            color: accent ? c.onAccent : c.textPrimary,
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
                builder: (_, v, __) => FractionallySizedBox(
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
                      Text(title, style: type.titleSm.copyWith(color: c.textPrimary)),
                      if (subtitle != null)
                        Text(subtitle!, style: type.bodySm.copyWith(color: c.textSecondary)),
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

/// Placeholder block with Nuvio's shimmer sweep (Skeleton.kt / Shimmer.kt).
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
