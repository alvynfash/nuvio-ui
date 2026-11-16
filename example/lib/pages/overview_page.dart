import 'package:flutter/material.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    return GalleryPage(
      title: 'nuvio_ui',
      intro:
          'A dark, cinematic design system modelled on the Nuvio desktop app. '
          'It has tokens, 12 accent palettes, a full Material 3 theme and a set of '
          'components, with no dependencies beyond Flutter. Change the palette '
          'and AMOLED mode in the top bar; every page updates live.',
      children: [
        Container(
          height: 220,
          padding: const EdgeInsets.all(NuvioSpace.s32),
          decoration: BoxDecoration(
            gradient: c.overlayGradient,
            borderRadius: NuvioRadius.all(NuvioRadius.card),
            border: Border.all(color: c.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShaderMask(
                shaderCallback: c.accentGradient.createShader,
                child: Text(
                  'THE ODYSSEY',
                  style: t.displayMd.copyWith(
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: NuvioSpace.s12),
              Row(
                children: [
                  NuvioPrimaryButton(
                    label: 'Play',
                    icon: Icons.play_arrow,
                    onPressed: () {},
                  ),
                  const SizedBox(width: NuvioSpace.s12),
                  const NuvioInfoBadge('4K HDR'),
                  const SizedBox(width: NuvioSpace.s6),
                  const NuvioInfoBadge('2026', accent: true),
                ],
              ),
            ],
          ),
        ),
        const Specimen(
          title: '1 · Install',
          preview: Text('Add the package and apply the theme once.'),
          code: '''
# pubspec.yaml
dependencies:
  nuvio_ui:
    git:
      url: https://github.com/alvynfash/nuvio-ui.git
      ref: main
''',
        ),
        const Specimen(
          title: '2 · Apply the theme',
          description:
              'Stock Material widgets restyle themselves automatically.',
          preview: Text('MaterialApp(theme: NuvioThemeData.build(...))'),
          code: '''
import 'package:nuvio_ui/nuvio_ui.dart';

MaterialApp(
  theme: NuvioThemeData.build(
    NuvioPalette.arcticBlue, // or any of NuvioPalette.all
    amoled: false,           // pure-black backgrounds
    // fontFamily defaults to the bundled JetBrains Sans
  ),
);
''',
        ),
        const Specimen(
          title: '3 · Use tokens in widgets',
          preview: Text(
            'context.nuvioColors · context.nuvioType · NuvioSpace · NuvioRadius · NuvioMotion',
          ),
          code: '''
final c = context.nuvioColors; // 43 semantic colours
final t = context.nuvioType;   // Nuvio type ramp

Container(
  padding: const EdgeInsets.all(NuvioSpace.cardPadding),
  decoration: BoxDecoration(
    color: c.surfaceCard,
    borderRadius: NuvioRadius.all(NuvioRadius.card),
  ),
  child: Text('Hello', style: t.titleMd.copyWith(color: c.textPrimary)),
);
''',
        ),
      ],
    );
  }
}
