import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

/// Nuvio's stream picker screen rebuilt from the design system.
class RecipePage extends HookWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final provider = useState('Torrentio RD');
    final selected = useState(0);

    const streams = [
      (
        'The Odyssey 2026 2160p UHD Blu-ray Remux HDR HEVC DTS-HD MA 5.1',
        '82.2 GB',
        '1337x',
      ),
      (
        'The.Odyssey.2026.2160p.UHD.Blu-ray.Remux.HDR.HEVC.DTS-HD.MA.5.1',
        '82.19 GB',
        'EXT',
      ),
      (
        'The Odyssey 2026 UHD BluRay 2160p HDR10 HEVC DTS-HD MA 5.1 x265',
        '37.41 GB',
        '1337x',
      ),
      ('The Odyssey (2026) iMAX 2160p H265 HDR10 EAC3', '6.36 GB', '1337x'),
      ('The Odyssey 2026 1080p WEB-DL DDP5.1 Atmos H.264', '9.8 GB', 'TPB'),
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: c.overlayGradient),
          ),
        ),
        Padding(
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: ShaderMask(
                        shaderCallback: c.accentGradient.createShader,
                        child: Text(
                          'THE\nODYSSEY',
                          style: t.displayMd.copyWith(
                            color: Colors.white,
                            fontSize: 64,
                            letterSpacing: 6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.s12),
                    const Wrap(
                      spacing: NuvioSpace.s6,
                      children: [
                        NuvioInfoBadge('2026'),
                        NuvioInfoBadge('2h 52m'),
                        NuvioInfoBadge('4K HDR', accent: true),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const SizedBox(width: NuvioSpace.s32),
              Expanded(
                flex: 2,
                child: NuvioGlassPanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: NuvioSpace.s8,
                        runSpacing: NuvioSpace.s8,
                        children: [
                          NuvioFilterPill(
                            icon: Icons.refresh_rounded,
                            selected: false,
                            onTap:
                                () => NuvioToast.show(
                                  context,
                                  'Refreshing streams…',
                                ),
                          ),
                          for (final p in const ['All', 'Torrentio RD'])
                            NuvioFilterPill(
                              label: p,
                              selected: provider.value == p,
                              onTap: () => provider.value = p,
                            ),
                        ],
                      ),
                      const SizedBox(height: NuvioSpace.s20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: streams.length,
                          separatorBuilder:
                              (_, _) =>
                                  const SizedBox(height: NuvioSpace.listGap),
                          itemBuilder: (_, i) {
                            final (name, size, source) = streams[i];
                            return NuvioListCard(
                              selected: selected.value == i,
                              onTap: () => selected.value = i,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '[RD+] Torrentio\n${i < 4 ? '4k HDR' : '1080p'}',
                                    style: t.bodyMd.copyWith(
                                      color: c.textPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: NuvioSpace.s4),
                                  Text(
                                    name,
                                    style: t.bodySm.copyWith(
                                      color: c.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: NuvioSpace.s6),
                                  Wrap(
                                    spacing: NuvioSpace.s6,
                                    children: [
                                      NuvioInfoBadge(size),
                                      NuvioInfoBadge(source),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
