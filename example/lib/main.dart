// Recreates the Nuvio stream-picker screen with the design system.
// Run from example/ after `flutter create .` (see README).

import 'package:flutter/material.dart';
import 'package:nuvio_design/nuvio_design.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  NuvioPalette _palette = NuvioPalette.white;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: NuvioThemeData.build(_palette),
        home: StreamsDemo(
          palette: _palette,
          onPalette: (p) => setState(() => _palette = p),
        ),
      );
}

class StreamsDemo extends StatelessWidget {
  const StreamsDemo({super.key, required this.palette, required this.onPalette});

  final NuvioPalette palette;
  final ValueChanged<NuvioPalette> onPalette;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    return Scaffold(
      body: Column(
        children: [
          const NuvioStatusBanner(
            icon: Icons.cloud_download,
            title: '0.1.36-alpha • 170 MB',
            subtitle: 'Downloading 78%',
            progress: 0.78,
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: c.overlayGradient),
              child: Padding(
                padding: const EdgeInsets.all(NuvioSpace.s32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NuvioCircleIconButton.back(onPressed: () {}),
                          const Spacer(),
                          Text('THE ODYSSEY', style: t.pageDisplay.copyWith(color: c.accent)),
                          const SizedBox(height: NuvioSpace.s16),
                          Wrap(
                            spacing: NuvioSpace.s8,
                            runSpacing: NuvioSpace.s8,
                            children: [
                              for (final p in NuvioPalette.all)
                                NuvioChip(
                                  label: p.name,
                                  selected: p == palette,
                                  onTap: () => onPalette(p),
                                ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(width: NuvioSpace.s32),
                    Expanded(
                      child: NuvioGlassPanel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                NuvioFilterPill(icon: Icons.refresh, selected: false, onTap: () {}),
                                const SizedBox(width: NuvioSpace.s8),
                                NuvioFilterPill(label: 'All', selected: false, onTap: () {}),
                                const SizedBox(width: NuvioSpace.s8),
                                NuvioFilterPill(label: 'Torrentio RD', selected: true, onTap: () {}),
                              ],
                            ),
                            const SizedBox(height: NuvioSpace.s20),
                            Expanded(
                              child: ListView.separated(
                                itemCount: 8,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: NuvioSpace.listGap),
                                itemBuilder: (_, i) => NuvioListCard(
                                  selected: i == 0,
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('[RD+] Torrentio\n4k HDR',
                                          style: t.bodyMd.copyWith(
                                              color: c.textPrimary,
                                              fontWeight: FontWeight.w700)),
                                      const SizedBox(height: NuvioSpace.s4),
                                      Text(
                                        'The Odyssey 2026 2160p UHD Blu-ray Remux HDR HEVC',
                                        style: t.bodySm.copyWith(color: c.textSecondary),
                                      ),
                                      const SizedBox(height: NuvioSpace.s6),
                                      const Wrap(spacing: NuvioSpace.s6, children: [
                                        NuvioInfoBadge('82.2 GB'),
                                        NuvioInfoBadge('1337x'),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
