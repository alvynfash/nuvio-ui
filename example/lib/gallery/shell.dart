import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../pages/buttons_page.dart';
import '../pages/chips_page.dart';
import '../pages/colors_page.dart';
import '../pages/feedback_page.dart';
import '../pages/inputs_page.dart';
import '../pages/material_page.dart';
import '../pages/motion_page.dart';
import '../pages/overlays_page.dart';
import '../pages/overview_page.dart';
import '../pages/palettes_page.dart';
import '../pages/recipe_page.dart';
import '../pages/settings_page.dart';
import '../pages/spacing_page.dart';
import '../pages/surfaces_page.dart';
import '../pages/typography_page.dart';
import 'settings.dart';

class GalleryEntry {
  const GalleryEntry(this.section, this.title, this.icon, this.builder);

  final String section;
  final String title;
  final IconData icon;
  final WidgetBuilder builder;
}

final galleryEntries = <GalleryEntry>[
  GalleryEntry('', 'Overview', Icons.auto_awesome, (_) => const OverviewPage()),
  GalleryEntry(
    'Foundations',
    'Palettes',
    Icons.palette_outlined,
    (_) => const PalettesPage(),
  ),
  GalleryEntry(
    'Foundations',
    'Colors',
    Icons.format_color_fill,
    (_) => const ColorsPage(),
  ),
  GalleryEntry(
    'Foundations',
    'Typography',
    Icons.text_fields,
    (_) => const TypographyPage(),
  ),
  GalleryEntry(
    'Foundations',
    'Spacing & shape',
    Icons.straighten,
    (_) => const SpacingPage(),
  ),
  GalleryEntry(
    'Foundations',
    'Motion',
    Icons.animation,
    (_) => const MotionPage(),
  ),
  GalleryEntry(
    'Components',
    'Buttons',
    Icons.smart_button_outlined,
    (_) => const ButtonsPage(),
  ),
  GalleryEntry(
    'Components',
    'Chips & pills',
    Icons.label_outline,
    (_) => const ChipsPage(),
  ),
  GalleryEntry(
    'Components',
    'Surfaces',
    Icons.layers_outlined,
    (_) => const SurfacesPage(),
  ),
  GalleryEntry(
    'Components',
    'Inputs & selection',
    Icons.toggle_on_outlined,
    (_) => const InputsPage(),
  ),
  GalleryEntry(
    'Components',
    'Feedback',
    Icons.downloading,
    (_) => const FeedbackPage(),
  ),
  GalleryEntry(
    'Components',
    'Overlays',
    Icons.web_asset_rounded,
    (_) => const OverlaysPage(),
  ),
  GalleryEntry(
    'Components',
    'Settings',
    Icons.tune_rounded,
    (_) => const SettingsPage(),
  ),
  GalleryEntry(
    'Material',
    'Themed Material',
    Icons.widgets_outlined,
    (_) => const ThemedMaterialPage(),
  ),
  GalleryEntry(
    'Recipes',
    'Stream picker',
    Icons.movie_outlined,
    (_) => const RecipePage(),
  ),
];

class GalleryShell extends HookWidget {
  const GalleryShell({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    useGalleryTour(index);
    final entry = galleryEntries[index.value];
    final wide =
        MediaQuery.sizeOf(context).width >= NuvioBreakpoint.largeTablet;
    final c = context.nuvioColors;

    void select(int i) {
      index.value = i;
      if (!wide) Navigator.of(context).maybePop();
    }

    final sidebar = _Sidebar(selected: index.value, onSelect: select);
    final page = KeyedSubtree(
      key: ValueKey(entry.title),
      child: entry.builder(context),
    );

    return Scaffold(
      drawer: wide ? null : Drawer(backgroundColor: c.surface, child: sidebar),
      appBar: AppBar(
        backgroundColor: c.background,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: !wide,
        titleSpacing: wide ? NuvioSpace.s24 : 0,
        title: Text(
          entry.title,
          style: context.nuvioType.titleSm.copyWith(color: c.textPrimary),
        ),
        actions: const [
          _PalettePicker(),
          _AmoledToggle(),
          SizedBox(width: NuvioSpace.s16),
        ],
      ),
      body:
          wide
              ? Row(
                children: [
                  SizedBox(width: 248, child: sidebar),
                  VerticalDivider(width: 1, color: c.borderSubtle),
                  Expanded(child: page),
                ],
              )
              : page,
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    final items = <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(
          NuvioSpace.s20,
          NuvioSpace.s24,
          NuvioSpace.s20,
          NuvioSpace.s16,
        ),
        child: ShaderMask(
          shaderCallback: c.accentGradient.createShader,
          child: Text(
            'nuvio_ui',
            style: t.titleMd.copyWith(color: Colors.white),
          ),
        ),
      ),
    ];
    var section = '';
    for (var i = 0; i < galleryEntries.length; i++) {
      final e = galleryEntries[i];
      if (e.section != section) {
        section = e.section;
        items.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(
              NuvioSpace.s20,
              NuvioSpace.s20,
              NuvioSpace.s20,
              NuvioSpace.s6,
            ),
            child: Text(
              section.toUpperCase(),
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: c.textMuted),
            ),
          ),
        );
      }
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: NuvioSpace.s10,
            vertical: NuvioSpace.s1,
          ),
          child: NuvioSidebarItem(
            label: e.title,
            icon: e.icon,
            selected: i == selected,
            onTap: () => onSelect(i),
          ),
        ),
      );
    }
    return ColoredBox(color: c.background, child: ListView(children: items));
  }
}

class _PalettePicker extends HookWidget {
  const _PalettePicker();

  @override
  Widget build(BuildContext context) {
    final settings = useValueListenable(gallerySettings);
    return PopupMenuButton<NuvioPalette>(
      tooltip: 'Palette',
      initialValue: settings.palette,
      onSelected: selectPalette,
      itemBuilder:
          (_) => [
            for (final p in NuvioPalette.all)
              PopupMenuItem(
                value: p,
                child: Row(
                  children: [
                    _Dot(p),
                    const SizedBox(width: NuvioSpace.s12),
                    Text(p.name),
                  ],
                ),
              ),
          ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: NuvioSpace.s12),
        child: Row(
          children: [
            _Dot(settings.palette),
            const SizedBox(width: NuvioSpace.s8),
            Text(settings.palette.name),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

class _AmoledToggle extends HookWidget {
  const _AmoledToggle();

  @override
  Widget build(BuildContext context) {
    final settings = useValueListenable(gallerySettings);
    return Tooltip(
      message: 'AMOLED (pure black background)',
      child: Row(
        children: [
          const Text('AMOLED'),
          const SizedBox(width: NuvioSpace.s6),
          Switch(value: settings.amoled, onChanged: setAmoled),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.palette);

  final NuvioPalette palette;

  @override
  Widget build(BuildContext context) => Container(
    width: 16,
    height: 16,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: palette.accentBrush,
    ),
  );
}

/// Screenshot tour, enabled with `--dart-define=GALLERY_TOUR=true`: steps
/// through key pages and palettes, logging `TOUR <n> <slug>` after each one
/// settles, then returns to the overview.
const _tourEnabled = bool.fromEnvironment('GALLERY_TOUR');

const _tour = [
  ('overview', 'Overview', NuvioPalette.arcticBlue),
  ('palettes', 'Palettes', NuvioPalette.gold),
  ('stream-picker', 'Stream picker', NuvioPalette.white),
  ('settings', 'Settings', NuvioPalette.jade),
  ('chips', 'Chips & pills', NuvioPalette.roseGold),
  ('typography', 'Typography', NuvioPalette.arcticBlue),
  ('colors', 'Colors', NuvioPalette.violet),
  ('inputs', 'Inputs & selection', NuvioPalette.crimson),
];

void useGalleryTour(ValueNotifier<int> index) {
  useEffect(() {
    if (!_tourEnabled) return null;
    var cancelled = false;
    Future<void> run() async {
      // Let the first frame and the simulator settle.
      await Future<void>.delayed(const Duration(seconds: 3));
      for (var step = 0; step < _tour.length && !cancelled; step++) {
        final (slug, title, palette) = _tour[step];
        selectPalette(palette);
        index.value = galleryEntries.indexWhere((e) => e.title == title);
        await Future<void>.delayed(const Duration(milliseconds: 2500));
        debugPrint('TOUR $step $slug');
        // Leave time for the screenshot before moving on.
        await Future<void>.delayed(const Duration(seconds: 4));
      }
      if (cancelled) return;
      selectPalette(NuvioPalette.arcticBlue);
      index.value = 0;
      debugPrint('TOUR done');
    }

    run();
    return () => cancelled = true;
  }, const []);
}
