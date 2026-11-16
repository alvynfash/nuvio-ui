import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class ButtonsPage extends HookWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final withIcon = useState(true);
    final enabled = useState(true);
    final expand = useState(false);
    final filled = useState(true);
    final taps = useState(0);

    return GalleryPage(
      title: 'Buttons',
      intro:
          'Nuvio’s primary call to action, round icon buttons, text links and '
          'the three dialog button styles.',
      children: [
        Specimen(
          title: 'NuvioPrimaryButton',
          description:
              '52 px tall, 16 px radius, accent fill. Nuvio stretches it to full width.',
          knobs: [
            BoolKnob('icon', withIcon.value, (v) => withIcon.value = v),
            BoolKnob('enabled', enabled.value, (v) => enabled.value = v),
            BoolKnob('expand', expand.value, (v) => expand.value = v),
          ],
          preview: Align(
            alignment: Alignment.centerLeft,
            child: NuvioPrimaryButton(
              label: 'Play S1 E1',
              icon: withIcon.value ? Icons.play_arrow_rounded : null,
              expand: expand.value,
              onPressed: enabled.value ? () => taps.value++ : null,
            ),
          ),
          code: '''
NuvioPrimaryButton(
  label: 'Play S1 E1',
  icon: Icons.play_arrow_rounded,
  expand: true,
  onPressed: () {},
)
''',
        ),
        Specimen(
          title: 'NuvioCircleIconButton',
          description:
              'Filled: translucent disc over artwork. Unfilled: Nuvio’s plain 40 px back button.',
          knobs: [BoolKnob('filled', filled.value, (v) => filled.value = v)],
          artBackground: true,
          preview: Wrap(
            spacing: NuvioSpace.s16,
            children: [
              NuvioCircleIconButton.back(
                filled: filled.value,
                size: filled.value ? 54 : 40,
                onPressed: () {},
              ),
              NuvioCircleIconButton(
                icon: Icons.more_horiz_rounded,
                tooltip: 'More',
                filled: filled.value,
                size: filled.value ? 54 : 40,
                onPressed: () {},
              ),
              NuvioCircleIconButton(
                icon: Icons.fullscreen_rounded,
                tooltip: 'Fullscreen',
                filled: filled.value,
                size: filled.value ? 54 : 40,
                onPressed: () {},
              ),
            ],
          ),
          code: '''
NuvioCircleIconButton.back(onPressed: () => Navigator.pop(context))
NuvioCircleIconButton(icon: Icons.more_horiz_rounded, tooltip: 'More', onPressed: () {})
''',
        ),
        Specimen(
          title: 'NuvioActionLabel',
          description:
              'Accent text link used for “See all” and inline actions.',
          preview: Row(
            children: [
              Text(
                'Continue watching',
                style: context.nuvioType.titleMd.copyWith(
                  color: context.nuvioColors.textPrimary,
                ),
              ),
              const Spacer(),
              NuvioActionLabel('See all', onTap: () => taps.value++),
            ],
          ),
          code: "NuvioActionLabel('See all', onTap: () {})",
        ),
        Specimen(
          title: 'NuvioDialogButton',
          description: 'Flat 48 px buttons for dialogs and sheets.',
          preview: Row(
            children: [
              for (final s in NuvioDialogButtonStyle.values) ...[
                Expanded(
                  child: NuvioDialogButton(
                    label: s.name[0].toUpperCase() + s.name.substring(1),
                    style: s,
                    icon:
                        s == NuvioDialogButtonStyle.destructive
                            ? Icons.delete_outline
                            : null,
                    onPressed: enabled.value ? () {} : null,
                  ),
                ),
                const SizedBox(width: NuvioSpace.s8),
              ],
            ],
          ),
          code: '''
NuvioDialogButton(label: 'Delete', style: NuvioDialogButtonStyle.destructive, onPressed: () {})
''',
        ),
        Text(
          'Taps: ${taps.value}',
          style: context.nuvioType.bodySm.copyWith(
            color: context.nuvioColors.textMuted,
          ),
        ),
      ],
    );
  }
}
