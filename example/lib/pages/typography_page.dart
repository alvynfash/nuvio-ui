import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class TypographyPage extends HookWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final tt = Theme.of(context).textTheme;
    final sample = useState('The Odyssey · 2160p HDR');

    final ramp = [
      ('pageDisplay', t.pageDisplay),
      ('displayMd', t.displayMd),
      ('displaySm', t.displaySm),
      ('titleLg', t.titleLg),
      ('headline', t.headline),
      ('titleMd', t.titleMd),
      ('titleSm', t.titleSm),
      ('bodyLg', t.bodyLg),
      ('bodyMd', t.bodyMd),
      ('bodySm', t.bodySm),
      ('labelSm', t.labelSm),
      ('labelXs', t.labelXs),
    ];
    final material = [
      ('displayLarge', tt.displayLarge),
      ('headlineLarge', tt.headlineLarge),
      ('titleLarge', tt.titleLarge),
      ('titleMedium', tt.titleMedium),
      ('bodyLarge', tt.bodyLarge),
      ('bodyMedium', tt.bodyMedium),
      ('labelLarge', tt.labelLarge),
      ('labelMedium', tt.labelMedium),
    ];

    Widget row(String name, TextStyle? s) => Padding(
      padding: const EdgeInsets.symmetric(vertical: NuvioSpace.s8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 170,
            child: TokenCaption(
              name,
              '${s!.fontSize!.toStringAsFixed(0)} / '
              '${(s.fontSize! * (s.height ?? 1)).toStringAsFixed(0)} · '
              'w${s.fontWeight?.value ?? 400}'
              '${(s.letterSpacing ?? 0) != 0 ? ' · ${s.letterSpacing}' : ''}',
            ),
          ),
          Expanded(
            child: Text(
              sample.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: s.copyWith(color: c.textPrimary),
            ),
          ),
        ],
      ),
    );

    return GalleryPage(
      title: 'Typography',
      intro:
          'Nuvio’s own ramp (context.nuvioType) plus the Material TextTheme slots it '
          'overrides. Captions show size / line height · weight · letter spacing.',
      children: [
        SizedBox(
          width: 420,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Sample text',
              prefixIcon: Icon(Icons.edit),
            ),
            onChanged:
                (v) => sample.value = v.isEmpty ? 'The Odyssey · 2160p HDR' : v,
          ),
        ),
        Specimen(
          title: 'Nuvio type ramp',
          preview: Column(children: [for (final (n, s) in ramp) row(n, s)]),
          code: '''
Text('Title', style: context.nuvioType.titleMd.copyWith(
  color: context.nuvioColors.textPrimary,
));
''',
        ),
        Specimen(
          title: 'Material TextTheme overrides',
          description: 'Slots not listed keep Material 3 defaults.',
          preview: Column(children: [for (final (n, s) in material) row(n, s)]),
          code: '''
Text('Body', style: Theme.of(context).textTheme.bodyLarge);
''',
        ),
        Specimen(
          title: 'Fonts',
          description:
              'JetBrains Sans 400 / 600 / 700 is bundled and used by default.',
          preview: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final w in const [
                FontWeight.w400,
                FontWeight.w600,
                FontWeight.w700,
              ])
                Text(
                  'JetBrains Sans ${w.value} · The quick brown fox jumps over the lazy dog',
                  style: t.bodyLg.copyWith(color: c.textPrimary, fontWeight: w),
                ),
            ],
          ),
          code: '''
// Default: bundled JetBrains Sans
NuvioThemeData.build(palette);

// Your own font (declared in your app's pubspec), or null for the platform font
NuvioThemeData.build(palette, fontFamily: 'Inter');
NuvioThemeData.build(palette, fontFamily: null);

// Direct use outside the theme
TextStyle(fontFamily: NuvioFonts.jetBrainsSans);
''',
        ),
      ],
    );
  }
}
