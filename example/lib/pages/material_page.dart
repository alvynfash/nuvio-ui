import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

/// Stock Material widgets with no Nuvio code: the theme does all the styling.
class ThemedMaterialPage extends HookWidget {
  const ThemedMaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = useState(true);
    final tile = useState(1);

    return GalleryPage(
      title: 'Themed Material',
      intro:
          'Plain Flutter widgets under NuvioThemeData.build(). Use these freely '
          'when no Nuvio component exists; they already match.',
      children: [
        Specimen(
          title: 'Buttons',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              FilledButton(onPressed: () {}, child: const Text('FilledButton')),
              FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              OutlinedButton(
                onPressed: () {},
                child: const Text('OutlinedButton'),
              ),
              TextButton(onPressed: () {}, child: const Text('TextButton')),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_rounded),
              ),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded),
              ),
              const FilledButton(onPressed: null, child: Text('Disabled')),
            ],
          ),
        ),
        Specimen(
          title: 'Chips',
          preview: Wrap(
            spacing: NuvioSpace.s8,
            runSpacing: NuvioSpace.s8,
            children: [
              FilterChip(
                label: const Text('FilterChip'),
                selected: filter.value,
                onSelected: (v) => filter.value = v,
              ),
              const Chip(label: Text('Chip')),
              ActionChip(label: const Text('ActionChip'), onPressed: () {}),
              InputChip(label: const Text('InputChip'), onDeleted: () {}),
            ],
          ),
        ),
        Specimen(
          title: 'TabBar',
          previewPadding: EdgeInsets.zero,
          preview: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Episodes'),
                    Tab(text: 'Cast'),
                    Tab(text: 'More like this'),
                  ],
                ),
                const SizedBox(
                  height: 80,
                  child: TabBarView(
                    children: [
                      Center(child: Text('Episodes')),
                      Center(child: Text('Cast')),
                      Center(child: Text('More like this')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Specimen(
          title: 'ListTile & Card',
          preview: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    for (var i = 0; i < 3; i++)
                      ListTile(
                        selected: tile.value == i,
                        onTap: () => tile.value = i,
                        leading: const Icon(Icons.movie_outlined),
                        title: Text('Episode ${i + 1}'),
                        subtitle: const Text('48 min'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: NuvioSpace.s16),
              const Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(NuvioSpace.cardPadding),
                    child: Text(
                      'Card uses surfaceCard and the 24 px card radius.',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Specimen(
          title: 'Dialogs, sheets & snackbars',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              OutlinedButton(
                onPressed:
                    () => showDialog<void>(
                      context: context,
                      builder:
                          (ctx) => AlertDialog(
                            title: const Text('AlertDialog'),
                            content: const Text(
                              'Stock dialog with the Nuvio theme.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    ),
                child: const Text('AlertDialog'),
              ),
              OutlinedButton(
                onPressed:
                    () => showModalBottomSheet<void>(
                      context: context,
                      builder:
                          (_) => const SizedBox(
                            height: 200,
                            child: Center(child: Text('Bottom sheet')),
                          ),
                    ),
                child: const Text('showModalBottomSheet'),
              ),
              OutlinedButton(
                onPressed:
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Snackbar'),
                        action: SnackBarAction(label: 'Undo', onPressed: () {}),
                      ),
                    ),
                child: const Text('SnackBar'),
              ),
            ],
          ),
        ),
        Specimen(
          title: 'Progress',
          preview: const Column(
            children: [
              LinearProgressIndicator(value: 0.6),
              SizedBox(height: NuvioSpace.s16),
              LinearProgressIndicator(),
              SizedBox(height: NuvioSpace.s16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ],
    );
  }
}
