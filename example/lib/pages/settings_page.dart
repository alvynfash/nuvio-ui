import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class SettingsPage extends HookWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final autoplay = useState(true);
    final skipIntro = useState(false);
    final trailers = useState(true);
    final buffer = useState(30.0);
    final subtitleSize = useState(1.0);
    final sidebar = useState(0);

    const sidebarItems = [
      ('Appearance', Icons.palette_outlined),
      ('Playback', Icons.play_circle_outline_rounded),
      ('Accounts', Icons.person_outline_rounded),
      ('About', Icons.info_outline_rounded),
    ];

    return GalleryPage(
      title: 'Settings',
      intro:
          'The building blocks of Nuvio’s settings screens: sections, grouped '
          'cards, switch, slider and navigation rows, and sidebar items.',
      children: [
        Specimen(
          title: 'Settings screen',
          previewPadding: const EdgeInsets.all(NuvioSpace.s16),
          preview: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 220,
                child: Column(
                  children: [
                    for (var i = 0; i < sidebarItems.length; i++) ...[
                      NuvioSidebarItem(
                        label: sidebarItems[i].$1,
                        icon: sidebarItems[i].$2,
                        selected: sidebar.value == i,
                        onTap: () => sidebar.value = i,
                      ),
                      const SizedBox(height: NuvioSpace.s2),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: NuvioSpace.s24),
              Expanded(
                child: Column(
                  children: [
                    NuvioSettingsSection(
                      title: 'Playback',
                      child: NuvioSettingsGroup(
                        children: [
                          NuvioSwitchRow(
                            title: 'Autoplay next episode',
                            description:
                                'Start the next episode when the credits roll.',
                            value: autoplay.value,
                            onChanged: (v) => autoplay.value = v,
                          ),
                          NuvioSwitchRow(
                            title: 'Skip intros automatically',
                            value: skipIntro.value,
                            onChanged: (v) => skipIntro.value = v,
                          ),
                          NuvioSwitchRow(
                            title: 'Trailer autoplay',
                            description: 'Available to supporters.',
                            value: trailers.value,
                            locked: true,
                            onChanged: (v) => trailers.value = v,
                          ),
                          NuvioSliderRow(
                            title: 'Buffer size',
                            description: 'Seconds of video to load ahead.',
                            value: buffer.value,
                            min: 10,
                            max: 120,
                            divisions: 11,
                            format: (v) => '${v.round()} s',
                            onChanged: (v) => buffer.value = v,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.sectionGap),
                    NuvioSettingsSection(
                      title: 'Subtitles',
                      actions: [
                        NuvioActionLabel(
                          'Reset',
                          onTap: () => subtitleSize.value = 1,
                        ),
                      ],
                      child: NuvioSettingsGroup(
                        children: [
                          NuvioNavigationRow(
                            icon: Icons.translate_rounded,
                            title: 'Preferred language',
                            value: 'English',
                            onTap: () {},
                          ),
                          NuvioSliderRow(
                            title: 'Text size',
                            value: subtitleSize.value,
                            min: 0.5,
                            max: 2,
                            format: (v) => '${(v * 100).round()} %',
                            onChanged: (v) => subtitleSize.value = v,
                          ),
                          NuvioNavigationRow(
                            icon: Icons.format_color_text_rounded,
                            title: 'Appearance',
                            description: 'Font, colour and background.',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          code: '''
NuvioSettingsSection(
  title: 'Playback',
  child: NuvioSettingsGroup(children: [
    NuvioSwitchRow(
      title: 'Autoplay next episode',
      description: 'Start the next episode when the credits roll.',
      value: autoplay,
      onChanged: (v) => setState(() => autoplay = v),
    ),
    NuvioSliderRow(
      title: 'Buffer size',
      value: buffer, min: 10, max: 120, divisions: 11,
      format: (v) => '\${v.round()} s',
      onChanged: (v) => setState(() => buffer = v),
    ),
    NuvioNavigationRow(title: 'Language', value: 'English', onTap: openLanguages),
  ]),
)

NuvioSidebarItem(label: 'Playback', icon: Icons.play_circle_outline, selected: true, onTap: () {})
''',
        ),
      ],
    );
  }
}
