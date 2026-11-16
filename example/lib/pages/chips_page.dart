import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class ChipsPage extends HookWidget {
  const ChipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final genres = useState(<String>{'Drama'});
    final enabled = useState(true);
    final provider = useState('Torrentio RD');
    final sort = useState<String?>('quality');
    final quality = useState<String?>(null);

    return GalleryPage(
      title: 'Chips & pills',
      intro:
          'Outlined chips for multi-select filters, pills for provider toggles, '
          'badges for metadata and the dropdown chip for compact selects.',
      children: [
        Specimen(
          title: 'NuvioChip',
          description:
              '8 px radius, thin border; white 15 % fill and accent border when selected.',
          knobs: [BoolKnob('enabled', enabled.value, (v) => enabled.value = v)],
          preview: Wrap(
            spacing: NuvioSpace.s8,
            runSpacing: NuvioSpace.s8,
            children: [
              for (final g in const [
                'Drama',
                'Sci-Fi',
                'Thriller',
                'Comedy',
                'Documentary',
              ])
                NuvioChip(
                  label: g,
                  enabled: enabled.value,
                  selected: genres.value.contains(g),
                  onTap:
                      () =>
                          genres.value =
                              genres.value.contains(g)
                                  ? ({...genres.value}..remove(g))
                                  : {...genres.value, g},
                ),
            ],
          ),
          code: '''
NuvioChip(label: 'Drama', selected: isSelected, onTap: toggle)
''',
        ),
        Specimen(
          title: 'NuvioFilterPill',
          description:
              '36 px pill; accent fill when selected; shrinks to 96 % while pressed. '
              'Pass an icon instead of a label for icon-only pills.',
          artBackground: true,
          preview: Wrap(
            spacing: NuvioSpace.s8,
            runSpacing: NuvioSpace.s8,
            children: [
              NuvioFilterPill(
                icon: Icons.refresh_rounded,
                selected: false,
                onTap: () {},
              ),
              for (final p in const [
                'All',
                'Torrentio RD',
                'Comet',
                'MediaFusion',
              ])
                NuvioFilterPill(
                  label: p,
                  selected: provider.value == p,
                  onTap: () => provider.value = p,
                ),
            ],
          ),
          code: '''
NuvioFilterPill(label: 'All', selected: current == 'All', onTap: () => select('All'))
NuvioFilterPill(icon: Icons.refresh_rounded, selected: false, onTap: refresh)
''',
        ),
        Specimen(
          title: 'NuvioDropdownChip',
          description: 'Compact select that opens a Nuvio-styled menu.',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              NuvioDropdownChip<String>(
                label: 'Sort',
                value: sort.value,
                options: const [
                  NuvioDropdownOption('quality', 'Quality'),
                  NuvioDropdownOption('size', 'Size'),
                  NuvioDropdownOption('seeders', 'Seeders'),
                ],
                onChanged: (v) => sort.value = v,
              ),
              NuvioDropdownChip<String>(
                value: quality.value,
                placeholder: 'Any quality',
                options: const [
                  NuvioDropdownOption('2160p', '4K'),
                  NuvioDropdownOption('1080p', '1080p'),
                  NuvioDropdownOption('720p', '720p'),
                ],
                onChanged: (v) => quality.value = v,
              ),
            ],
          ),
          code: '''
NuvioDropdownChip<String>(
  label: 'Sort',
  value: sort,
  options: const [
    NuvioDropdownOption('quality', 'Quality'),
    NuvioDropdownOption('size', 'Size'),
  ],
  onChanged: (v) => setState(() => sort = v),
)
''',
        ),
        const Specimen(
          title: 'NuvioInfoBadge',
          description:
              'Muted pill for metadata; the accent variant is an addition for highlights.',
          preview: Wrap(
            spacing: NuvioSpace.s8,
            runSpacing: NuvioSpace.s8,
            children: [
              NuvioInfoBadge('4K HDR'),
              NuvioInfoBadge('Dolby Vision'),
              NuvioInfoBadge('82.2 GB'),
              NuvioInfoBadge('New', accent: true),
            ],
          ),
          code:
              "const NuvioInfoBadge('4K HDR')\nconst NuvioInfoBadge('New', accent: true)",
        ),
        const Specimen(
          title: 'NuvioInlineMetadata',
          preview: Wrap(
            spacing: NuvioSpace.s24,
            runSpacing: NuvioSpace.s8,
            children: [
              NuvioInlineMetadata(
                label: 'Director',
                value: 'Christopher Nolan',
              ),
              NuvioInlineMetadata(label: 'Runtime', value: '2h 52m'),
            ],
          ),
          code: "const NuvioInlineMetadata(label: 'Runtime', value: '2h 52m')",
        ),
      ],
    );
  }
}
