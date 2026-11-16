import 'package:flutter/material.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final groups = <String, List<(String, Color)>>{
      'Surfaces': [
        ('background', c.background),
        ('surface', c.surface),
        ('surfaceElevated', c.surfaceElevated),
        ('surfaceCard', c.surfaceCard),
        ('surfaceSheet', c.surfaceSheet),
        ('surfaceDialog', c.surfaceDialog),
        ('surfacePopover', c.surfacePopover),
        ('nativeChrome', c.nativeChrome),
      ],
      'Text': [
        ('textPrimary', c.textPrimary),
        ('textSecondary', c.textSecondary),
        ('textMuted', c.textMuted),
        ('textDisabled', c.textDisabled),
        ('textInverse', c.textInverse),
      ],
      'Accent & focus': [
        ('accent', c.accent),
        ('accentStrong', c.accentStrong),
        ('onAccent', c.onAccent),
        ('focusRing', c.focusRing),
        ('focusBackground', c.focusBackground),
      ],
      'Borders': [
        ('borderSubtle', c.borderSubtle),
        ('borderDefault', c.borderDefault),
        ('borderStrong', c.borderStrong),
        ('borderFocus', c.borderFocus),
        ('borderSelected', c.borderSelected),
      ],
      'Status': [
        ('success', c.success),
        ('warning', c.warning),
        ('danger', c.danger),
        ('onDanger', c.onDanger),
        ('info', c.info),
        ('neutral', c.neutral),
      ],
      'Overlays & states': [
        ('overlayScrim', c.overlayScrim),
        ('overlayHover', c.overlayHover),
        ('overlayPressed', c.overlayPressed),
        ('overlaySelected', c.overlaySelected),
        ('overlayDisabled', c.overlayDisabled),
        ('shimmer', c.shimmer),
        ('skeleton', c.skeleton),
        ('glassFill', c.glassFill),
        ('glassPanel', c.glassPanel),
      ],
      'Player': [
        ('playerControlsBackground', c.playerControlsBackground),
        ('playerControlsForeground', c.playerControlsForeground),
        ('playerTimelineTrack', c.playerTimelineTrack),
        ('playerTimelineFill', c.playerTimelineFill),
        ('playerSubtitlePreview', c.playerSubtitlePreview),
        ('playerBuffering', c.playerBuffering),
        ('parentalGuide', c.parentalGuide),
      ],
    };
    return GalleryPage(
      title: 'Colors',
      intro:
          'Semantic colour roles from NuvioColors (a ThemeExtension). Translucent '
          'roles are shown over a checkerboard. Values follow the selected palette.',
      children: [
        for (final MapEntry(key: name, value: swatches) in groups.entries)
          Specimen(
            title: name,
            preview: Wrap(
              spacing: NuvioSpace.s16,
              runSpacing: NuvioSpace.s16,
              children: [for (final (n, col) in swatches) _Swatch(n, col)],
            ),
          ),
        Specimen(
          title: 'Gradients',
          preview: Wrap(
            spacing: NuvioSpace.s16,
            runSpacing: NuvioSpace.s16,
            children: [
              _GradientSwatch('accentGradient', c.accentGradient),
              _GradientSwatch('surfaceEdge', c.surfaceEdge),
              _GradientSwatch('overlayGradient', c.overlayGradient),
            ],
          ),
          code: '''
final c = context.nuvioColors;
Container(color: c.surfaceCard);
Text('Muted', style: TextStyle(color: c.textMuted));
DecoratedBox(decoration: BoxDecoration(gradient: c.overlayGradient));
ShaderMask(shaderCallback: c.accentGradient.createShader, child: ...);
''',
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: NuvioRadius.all(NuvioRadius.md),
          child: SizedBox(
            height: 64,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (color.a < 1) const _Checkerboard(),
                ColoredBox(color: color),
              ],
            ),
          ),
        ),
        const SizedBox(height: NuvioSpace.s6),
        TokenCaption(name, hex(color)),
      ],
    ),
  );
}

class _GradientSwatch extends StatelessWidget {
  const _GradientSwatch(this.name, this.gradient);

  final String name;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 240,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: NuvioRadius.all(NuvioRadius.md),
            border: Border.all(color: context.nuvioColors.borderSubtle),
          ),
        ),
        const SizedBox(height: NuvioSpace.s6),
        TokenCaption(name, 'LinearGradient'),
      ],
    ),
  );
}

class _Checkerboard extends StatelessWidget {
  const _Checkerboard();

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _CheckerPainter());
}

class _CheckerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cell = 8.0;
    final light = Paint()..color = const Color(0xFF3A3A3A);
    canvas.drawColor(const Color(0xFF2A2A2A), BlendMode.src);
    for (var y = 0.0; y < size.height; y += cell) {
      for (var x = 0.0; x < size.width; x += cell) {
        if (((x + y) / cell).round().isEven) {
          canvas.drawRect(Rect.fromLTWH(x, y, cell, cell), light);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_CheckerPainter oldDelegate) => false;
}
