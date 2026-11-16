import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class SurfacesPage extends HookWidget {
  const SurfacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final compact = useState(false);
    final blur = useState(0.0);
    final selected = useState(0);

    return GalleryPage(
      title: 'Surfaces',
      intro:
          'Cards and panels. Opaque cards sit on the page background; glass '
          'surfaces sit over artwork.',
      children: [
        Specimen(
          title: 'NuvioSurfaceCard',
          description:
              'Surface colour, 24 px radius (12 px when compact), card padding.',
          knobs: [BoolKnob('compact', compact.value, (v) => compact.value = v)],
          preview: NuvioSurfaceCard(
            compact: compact.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: t.titleSm.copyWith(color: c.textPrimary),
                ),
                const SizedBox(height: NuvioSpace.s4),
                Text(
                  'Signed in as viewer@example.com',
                  style: t.bodyMd.copyWith(color: c.textMuted),
                ),
              ],
            ),
          ),
          code: "NuvioSurfaceCard(child: Text('Account'))",
        ),
        Specimen(
          title: 'NuvioGlassPanel',
          description:
              'Black 42 % panel with a faint outline. Nuvio uses plain '
              'translucency; blur is optional.',
          artBackground: true,
          knobs: [
            SliderKnob('blur', blur.value, (v) => blur.value = v, max: 24),
          ],
          previewPadding: EdgeInsets.zero,
          preview: SizedBox(
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: NuvioSpace.s32),
                      child: ShaderMask(
                        shaderCallback: c.accentGradient.createShader,
                        child: Text(
                          'ODYSSEY',
                          style: t.displayMd.copyWith(
                            color: Colors.white,
                            fontSize: 72,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: NuvioSpace.s24,
                  top: NuvioSpace.s24,
                  bottom: NuvioSpace.s24,
                  width: 300,
                  child: NuvioGlassPanel(
                    blur: blur.value,
                    child: Text(
                      'Panel content',
                      style: t.bodyMd.copyWith(color: c.textPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          code: 'NuvioGlassPanel(blur: 12, child: ...)',
        ),
        Specimen(
          title: 'NuvioListCard',
          description:
              'Translucent row card (stream results): white 5 % fill, accent '
              'tint and outline when selected.',
          artBackground: true,
          preview: Column(
            children: [
              for (var i = 0; i < 3; i++) ...[
                NuvioListCard(
                  selected: selected.value == i,
                  onTap: () => selected.value = i,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '[RD+] Torrentio\n4k HDR',
                        style: t.bodyMd.copyWith(
                          color: c.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: NuvioSpace.s4),
                      Text(
                        'The.Odyssey.2026.2160p.UHD.Blu-ray.Remux.HDR.HEVC',
                        style: t.bodySm.copyWith(color: c.textSecondary),
                      ),
                      const SizedBox(height: NuvioSpace.s6),
                      const Wrap(
                        spacing: NuvioSpace.s6,
                        children: [
                          NuvioInfoBadge('82.2 GB'),
                          NuvioInfoBadge('1337x'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: NuvioSpace.listGap),
              ],
            ],
          ),
          code: '''
NuvioListCard(
  selected: index == current,
  onTap: () => select(index),
  child: Text('[RD+] Torrentio 4k HDR'),
)
''',
        ),
        Specimen(
          title: 'NuvioSectionLabel',
          preview: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NuvioSectionLabel('TRENDING NOW'),
              Text('…rail content…'),
            ],
          ),
          code: "const NuvioSectionLabel('TRENDING NOW')",
        ),
        Specimen(
          title: 'NuvioEdgeOutlined',
          description:
              'Building block used by dialogs and sheets: 1 px top-lit gradient edge.',
          preview: SizedBox(
            width: 280,
            height: 120,
            child: NuvioEdgeOutlined(
              radius: NuvioRadius.card,
              color: c.surfaceElevated,
              child: Center(
                child: Text(
                  'surfaceEdge',
                  style: t.bodyMd.copyWith(color: c.textSecondary),
                ),
              ),
            ),
          ),
          code:
              'NuvioEdgeOutlined(radius: NuvioRadius.card, color: c.surfaceElevated, child: ...)',
        ),
      ],
    );
  }
}
