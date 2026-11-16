import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class FeedbackPage extends HookWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.4);
    final indeterminate = useState(false);
    final download = useState<double?>(null);
    final promptVisible = useState(true);

    // Simulated update download for the banner.
    useEffect(() {
      if (download.value == null || download.value! >= 1) return null;
      final timer = Timer.periodic(const Duration(milliseconds: 120), (_) {
        final next = (download.value ?? 0) + 0.02;
        download.value = next >= 1 ? 1 : next;
      });
      return timer.cancel;
    }, [download.value == null || download.value! >= 1]);

    final d = download.value;
    final pct = ((d ?? 0) * 100).round();

    return GalleryPage(
      title: 'Feedback',
      intro:
          'Progress, loading, empty states, status banners, toasts and the '
          'resume prompt.',
      children: [
        Specimen(
          title: 'NuvioToast',
          description:
              'Bottom toast on the popover surface, 2.5 s by default; a new toast replaces the old.',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              FilledButton(
                onPressed:
                    () => NuvioToast.show(context, 'Added to your library'),
                child: const Text('Show toast'),
              ),
              OutlinedButton(
                onPressed:
                    () => NuvioToast.show(
                      context,
                      'Couldn’t reach the server. Retrying…',
                      duration: const Duration(seconds: 5),
                    ),
                child: const Text('Long toast (5 s)'),
              ),
            ],
          ),
          code: "NuvioToast.show(context, 'Added to your library');",
        ),
        Specimen(
          title: 'NuvioStatusBanner',
          description:
              'Full-width strip with progress fill, like Nuvio’s in-app update banner.',
          previewPadding: EdgeInsets.zero,
          knobs: [
            FilledButton.icon(
              onPressed: () => download.value = 0,
              icon: const Icon(Icons.cloud_download_rounded),
              label: const Text('Simulate download'),
            ),
          ],
          preview: ClipRRect(
            borderRadius: NuvioRadius.all(NuvioRadius.lg),
            child: NuvioStatusBanner(
              icon:
                  d != null && d >= 1
                      ? Icons.check_circle_rounded
                      : Icons.cloud_download_rounded,
              title: '0.1.37-alpha • 170 MB',
              subtitle: switch (d) {
                null => 'A new version is available',
                >= 1 => 'A new version is ready to install',
                _ => 'Downloading $pct%',
              },
              progress: d,
              actions: [
                if (d == null)
                  TextButton(
                    onPressed: () => download.value = 0,
                    child: const Text('Download'),
                  )
                else if (d >= 1)
                  TextButton(
                    onPressed: () => download.value = null,
                    child: const Text('Install'),
                  ),
              ],
            ),
          ),
          code: '''
NuvioStatusBanner(
  icon: Icons.cloud_download_rounded,
  title: '0.1.37-alpha • 170 MB',
  subtitle: 'Downloading 78%',
  progress: 0.78,
)
''',
        ),
        Specimen(
          title: 'NuvioProgressBar',
          knobs: [
            SliderKnob('value', progress.value, (v) => progress.value = v),
            BoolKnob(
              'indeterminate',
              indeterminate.value,
              (v) => indeterminate.value = v,
            ),
          ],
          preview: NuvioProgressBar(
            value: indeterminate.value ? null : progress.value,
          ),
          code: 'NuvioProgressBar(value: 0.4)  // null = indeterminate',
        ),
        const Specimen(
          title: 'NuvioLoadingIndicator',
          preview: Wrap(
            spacing: NuvioSpace.s24,
            children: [
              NuvioLoadingIndicator(),
              NuvioLoadingIndicator(size: NuvioSpace.s24),
            ],
          ),
          code: 'const NuvioLoadingIndicator()',
        ),
        Specimen(
          title: 'NuvioSkeleton',
          description: 'Shimmering placeholders while content loads.',
          preview: Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                const NuvioSkeleton(width: 110, height: 165),
                const SizedBox(width: NuvioSpace.railGap),
              ],
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NuvioSkeleton(
                      height: 18,
                      width: 220,
                      radius: NuvioRadius.xs,
                    ),
                    SizedBox(height: NuvioSpace.s8),
                    NuvioSkeleton(
                      height: 14,
                      width: 160,
                      radius: NuvioRadius.xs,
                    ),
                  ],
                ),
              ),
            ],
          ),
          code: 'const NuvioSkeleton(width: 110, height: 165)',
        ),
        Specimen(
          title: 'NuvioEmptyState',
          preview: SizedBox(
            width: 420,
            child: NuvioEmptyState(
              icon: Icons.wifi_off_rounded,
              title: 'You’re offline',
              message: 'Check your connection and try again.',
              actionLabel: 'Retry',
              onAction: () => NuvioToast.show(context, 'Retrying…'),
            ),
          ),
          code: '''
NuvioEmptyState(
  icon: Icons.wifi_off_rounded,
  title: 'You’re offline',
  message: 'Check your connection and try again.',
  actionLabel: 'Retry',
  onAction: retry,
)
''',
        ),
        Specimen(
          title: 'NuvioResumePrompt',
          description:
              'Floating “continue watching” card; slides in and out with visible.',
          knobs: [
            BoolKnob(
              'visible',
              promptVisible.value,
              (v) => promptVisible.value = v,
            ),
          ],
          artBackground: true,
          preview: SizedBox(
            height: 140,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NuvioResumePrompt(
                  visible: promptVisible.value,
                  title: 'The Odyssey',
                  subtitle: '1h 12m left',
                  progress: 0.58,
                  onPlay: () => NuvioToast.show(context, 'Resuming…'),
                  onDismiss: () => promptVisible.value = false,
                ),
              ),
            ),
          ),
          code: '''
NuvioResumePrompt(
  visible: show,
  title: 'The Odyssey',
  subtitle: '1h 12m left',
  progress: 0.58,
  poster: NetworkImage(posterUrl),
  onPlay: resume,
  onDismiss: hide,
)
''',
        ),
      ],
    );
  }
}
