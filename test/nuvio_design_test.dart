import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nuvio_design/nuvio_design.dart';

void main() {
  test('every palette builds a theme exposing both extensions', () {
    for (final p in NuvioPalette.all) {
      for (final amoled in [false, true]) {
        final theme = NuvioThemeData.build(p, amoled: amoled);
        final c = theme.extension<NuvioColors>()!;
        expect(theme.colorScheme.primary, p.secondary);
        expect(c.background, amoled ? const Color(0xFF000000) : p.background);
        expect(theme.extension<NuvioTypeScale>(), isNotNull);
      }
    }
  });

  test('desktop UI scale clamps to 1.0..1.18', () {
    expect(NuvioThemeData.desktopUiScale(const Size(800, 600)), 1.0);
    expect(NuvioThemeData.desktopUiScale(const Size(1408, 902)), closeTo(1.1, 1e-9));
    expect(NuvioThemeData.desktopUiScale(const Size(4000, 3000)), 1.18);
  });

  testWidgets('all widgets render without errors', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    var tapped = 0;
    await tester.pumpWidget(MaterialApp(
      theme: NuvioThemeData.build(NuvioPalette.gold),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const NuvioStatusBanner(
                icon: Icons.cloud_download,
                title: '0.1.36-alpha • 170 MB',
                subtitle: 'Downloading 78%',
                progress: 0.78,
              ),
              NuvioPrimaryButton(label: 'Play', icon: Icons.play_arrow, onPressed: () {}),
              NuvioCircleIconButton.back(onPressed: () {}),
              NuvioChip(label: 'Gold', selected: true, onTap: () => tapped++),
              NuvioFilterPill(label: 'All', selected: false, onTap: () => tapped++),
              NuvioFilterPill(icon: Icons.refresh, selected: true, onTap: () {}),
              const NuvioSurfaceCard(child: Text('card')),
              const NuvioGlassPanel(blur: 12, child: Text('glass')),
              NuvioListCard(selected: true, onTap: () {}, child: const Text('stream')),
              const NuvioSectionLabel('Section'),
              const NuvioProgressBar(value: 0.4),
              const NuvioProgressBar(value: null),
              const NuvioInfoBadge('4K HDR', accent: true),
              const NuvioSkeleton(width: 120, height: 60),
            ],
          ),
        ),
      ),
    ));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Gold'));
    await tester.tap(find.text('All'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(tapped, 2);
    expect(tester.takeException(), isNull);
  });
}
