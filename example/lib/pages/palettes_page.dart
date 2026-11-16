import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/settings.dart';
import '../gallery/specimen.dart';

class PalettesPage extends HookWidget {
  const PalettesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final current = useValueListenable(gallerySettings).palette;
    return GalleryPage(
      title: 'Palettes',
      intro:
          'Twelve accent themes. The first five have gradient accents; the rest '
          'are solid. Each palette also tints the background, elevated and card '
          'surfaces. Click one to apply it to the whole gallery.',
      children: [
        Wrap(
          spacing: NuvioSpace.s16,
          runSpacing: NuvioSpace.s16,
          children: [
            for (final p in NuvioPalette.all)
              _PaletteCard(
                palette: p,
                selected: p == current,
                onTap: () => selectPalette(p),
              ),
          ],
        ),
        const Specimen(
          title: 'Using a palette',
          preview: Text(
            'Palettes are plain const objects; build a theme from any of them.',
          ),
          code: '''
NuvioThemeData.build(NuvioPalette.gold);

// Raw palette values are available too:
NuvioPalette.gold.secondary;      // accent
NuvioPalette.gold.accentBrush;    // LinearGradient for ShaderMask / decorations
NuvioPalette.all;                 // all 12, e.g. for a theme picker
''',
        ),
      ],
    );
  }
}

class _PaletteCard extends StatelessWidget {
  const _PaletteCard({
    required this.palette,
    required this.selected,
    required this.onTap,
  });

  final NuvioPalette palette;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final swatches = [
      ('accent', palette.secondary),
      ('variant', palette.secondaryVariant),
      ('focus', palette.focusRing),
      ('bg', palette.background),
      ('elevated', palette.backgroundElevated),
      ('card', palette.backgroundCard),
    ];
    return SizedBox(
      width: 260,
      child: NuvioListCard(
        selected: selected,
        onTap: onTap,
        padding: const EdgeInsets.all(NuvioSpace.s14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: palette.accentBrush,
                borderRadius: NuvioRadius.all(NuvioRadius.md),
              ),
              alignment: Alignment.center,
              child: Text(
                'Aa',
                style: t.titleMd.copyWith(color: palette.onSecondary),
              ),
            ),
            const SizedBox(height: NuvioSpace.s10),
            Text(palette.name, style: t.titleSm.copyWith(color: c.textPrimary)),
            const SizedBox(height: NuvioSpace.s8),
            Row(
              children: [
                for (final (name, color) in swatches)
                  Expanded(
                    child: Tooltip(
                      message: '$name ${hex(color)}',
                      child: Container(
                        height: 22,
                        margin: const EdgeInsets.only(right: NuvioSpace.s4),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: NuvioRadius.all(NuvioRadius.xs),
                          border: Border.all(color: c.borderSubtle),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
