import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class OverlaysPage extends HookWidget {
  const OverlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final speed = useState('1.0×');

    Future<void> confirmDelete() async {
      final ok = await showNuvioDialog<bool>(
        context,
        builder:
            (ctx) => NuvioDialog(
              title: 'Remove from library?',
              message:
                  'The Odyssey will be removed from your library and watch history.',
              actions: [
                NuvioDialogButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(ctx, false),
                ),
                NuvioDialogButton(
                  label: 'Remove',
                  icon: Icons.delete_outline_rounded,
                  style: NuvioDialogButtonStyle.destructive,
                  onPressed: () => Navigator.pop(ctx, true),
                ),
              ],
            ),
      );
      if (context.mounted && ok == true) {
        NuvioToast.show(context, 'Removed from library');
      }
    }

    Future<void> chooseQuality() async {
      final choice = await showNuvioDialog<String>(
        context,
        builder:
            (ctx) => HookBuilder(
              builder: (ctx) {
                final selected = useState('1080p');
                return NuvioDialog(
                  title: 'Preferred quality',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final q in const ['4K', '1080p', '720p'])
                        NuvioOptionTile(
                          title: q,
                          selected: selected.value == q,
                          onTap: () => selected.value = q,
                        ),
                    ],
                  ),
                  actions: [
                    NuvioDialogButton(
                      label: 'Cancel',
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    NuvioDialogButton(
                      label: 'Save',
                      style: NuvioDialogButtonStyle.primary,
                      onPressed: () => Navigator.pop(ctx, selected.value),
                    ),
                  ],
                );
              },
            ),
      );
      if (context.mounted && choice != null) {
        NuvioToast.show(context, 'Quality set to $choice');
      }
    }

    void openSheet() => showNuvioBottomSheet<void>(
      context,
      title: 'The Odyssey',
      builder:
          (ctx) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NuvioSheetActionRow(
                icon: Icons.play_arrow_rounded,
                label: 'Resume from 1:40:12',
                onTap: () => Navigator.pop(ctx),
              ),
              NuvioSheetActionRow(
                icon: Icons.bookmark_add_outlined,
                label: 'Add to library',
                onTap: () => Navigator.pop(ctx),
              ),
              const NuvioSheetDivider(),
              NuvioSheetActionRow(
                icon: Icons.check_circle_outline_rounded,
                label: 'Mark as watched',
                onTap: () => Navigator.pop(ctx),
              ),
              NuvioSheetActionRow(
                icon: Icons.share_rounded,
                label: 'Share',
                trailing: Icon(
                  Icons.open_in_new_rounded,
                  size: NuvioIconSize.sm,
                  color: ctx.nuvioColors.textMuted,
                ),
                onTap: () => Navigator.pop(ctx),
              ),
            ],
          ),
    );

    return GalleryPage(
      title: 'Overlays',
      intro:
          'Dialogs, bottom sheets and menus. Each has a gradient top edge and sits over Nuvio’s 56 % scrim.',
      children: [
        Specimen(
          title: 'NuvioDialog',
          description:
              '460 px max width, 28 px radius, 20 px padding. Buttons share the width.',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              FilledButton(
                onPressed: confirmDelete,
                child: const Text('Confirm dialog'),
              ),
              OutlinedButton(
                onPressed: chooseQuality,
                child: const Text('Choice dialog'),
              ),
            ],
          ),
          code: '''
final ok = await showNuvioDialog<bool>(
  context,
  builder: (ctx) => NuvioDialog(
    title: 'Remove from library?',
    message: 'The Odyssey will be removed from your library.',
    actions: [
      NuvioDialogButton(label: 'Cancel', onPressed: () => Navigator.pop(ctx, false)),
      NuvioDialogButton(
        label: 'Remove',
        style: NuvioDialogButtonStyle.destructive,
        onPressed: () => Navigator.pop(ctx, true),
      ),
    ],
  ),
);
''',
        ),
        Specimen(
          title: 'showNuvioBottomSheet',
          description:
              'Inset 10 px from the edges, 28 px radius, drag handle, icon action rows.',
          preview: Align(
            alignment: Alignment.centerLeft,
            child: FilledButton(
              onPressed: openSheet,
              child: const Text('Open sheet'),
            ),
          ),
          code: '''
showNuvioBottomSheet(
  context,
  title: 'The Odyssey',
  builder: (ctx) => Column(mainAxisSize: MainAxisSize.min, children: [
    NuvioSheetActionRow(icon: Icons.play_arrow_rounded, label: 'Resume', onTap: resume),
    const NuvioSheetDivider(),
    NuvioSheetActionRow(icon: Icons.share_rounded, label: 'Share', onTap: share),
  ]),
);
''',
        ),
        Specimen(
          title: 'Menus (MenuAnchor + NuvioMenuItem)',
          description:
              '180 px minimum width, 20 px radius, 12 px item radius, accent check for the current choice.',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            children: [
              MenuAnchor(
                menuChildren: [
                  for (final s in const [
                    '0.5×',
                    '1.0×',
                    '1.25×',
                    '1.5×',
                    '2.0×',
                  ])
                    NuvioMenuItem(
                      label: s,
                      selected: speed.value == s,
                      onPressed: () => speed.value = s,
                    ),
                ],
                builder:
                    (_, controller, _) => OutlinedButton.icon(
                      onPressed:
                          () =>
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open(),
                      icon: const Icon(Icons.speed_rounded),
                      label: Text('Speed ${speed.value}'),
                    ),
              ),
              MenuAnchor(
                menuChildren: [
                  NuvioMenuItem(
                    icon: Icons.info_outline_rounded,
                    label: 'Details',
                    onPressed: () {},
                  ),
                  NuvioMenuItem(
                    icon: Icons.download_rounded,
                    label: 'Download',
                    onPressed: () {},
                  ),
                  NuvioMenuItem(
                    icon: Icons.copy_rounded,
                    label: 'Copy stream link',
                    onPressed: () {},
                  ),
                ],
                builder:
                    (_, controller, _) => IconButton(
                      onPressed:
                          () =>
                              controller.isOpen
                                  ? controller.close()
                                  : controller.open(),
                      icon: const Icon(Icons.more_vert_rounded),
                    ),
              ),
            ],
          ),
          code: '''
MenuAnchor(
  menuChildren: [
    NuvioMenuItem(label: '1.0×', selected: speed == 1.0, onPressed: () => setSpeed(1.0)),
    NuvioMenuItem(label: '1.5×', selected: speed == 1.5, onPressed: () => setSpeed(1.5)),
  ],
  builder: (_, controller, __) => IconButton(
    onPressed: controller.open,
    icon: const Icon(Icons.speed_rounded),
  ),
)
''',
        ),
        Specimen(
          title: 'Tooltip',
          preview: const Tooltip(
            message: 'Popover surface, 8 px radius',
            child: Icon(Icons.info_outline_rounded),
          ),
          code: "Tooltip(message: 'Hint', child: Icon(Icons.info_outline))",
        ),
      ],
    );
  }
}
