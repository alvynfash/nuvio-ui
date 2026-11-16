import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class MotionPage extends HookWidget {
  const MotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final forward = useState(false);
    final curve = useState<(String, Curve)>(('standard', NuvioMotion.standard));

    const durations = [
      ('fast', NuvioMotion.fast),
      ('normal', NuvioMotion.normal),
      ('sheetExit', NuvioMotion.sheetExit),
      ('sheetEnter', NuvioMotion.sheetEnter),
      ('slow', NuvioMotion.slow),
      ('cinematic', NuvioMotion.cinematic),
    ];
    const curves = [
      ('standard', NuvioMotion.standard),
      ('emphasized', NuvioMotion.emphasized),
      ('decelerate', NuvioMotion.decelerate),
      ('accelerate', NuvioMotion.accelerate),
    ];

    return GalleryPage(
      title: 'Motion',
      intro:
          'Durations and easing curves from NuvioMotionTokens. Press Play to run '
          'every duration with the selected curve.',
      children: [
        Specimen(
          title: 'Durations × curve',
          knobs: [
            NuvioPrimaryButton(
              label: forward.value ? 'Reverse' : 'Play',
              icon: Icons.play_arrow_rounded,
              onPressed: () => forward.value = !forward.value,
            ),
            for (final cv in curves)
              NuvioChip(
                label: cv.$1,
                selected: curve.value.$1 == cv.$1,
                onTap: () => curve.value = cv,
              ),
          ],
          preview: Column(
            children: [
              for (final (name, d) in durations)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: NuvioSpace.s6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: TokenCaption(name, '${d.inMilliseconds} ms'),
                      ),
                      Expanded(
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: c.skeleton,
                            borderRadius: NuvioRadius.all(NuvioRadius.full),
                          ),
                          child: AnimatedAlign(
                            alignment:
                                forward.value
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            duration: d,
                            curve: curve.value.$2,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: c.accentGradient,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          code: '''
AnimatedContainer(
  duration: NuvioMotion.normal,   // 220 ms
  curve: NuvioMotion.standard,    // Cubic(0.2, 0, 0, 1)
  ...
);
''',
        ),
        Specimen(
          title: 'Curves',
          preview: Wrap(
            spacing: NuvioSpace.s24,
            runSpacing: NuvioSpace.s16,
            children: [
              for (final (name, cv) in curves)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 100,
                      child: CustomPaint(
                        painter: _CurvePainter(cv, c.accent, c.borderDefault),
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.s6),
                    TokenCaption(name, _describe(cv)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

String _describe(Curve c) =>
    c is Cubic ? 'Cubic(${c.a}, ${c.b}, ${c.c}, ${c.d})' : c.toString();

class _CurvePainter extends CustomPainter {
  _CurvePainter(this.curve, this.color, this.grid);

  final Curve curve;
  final Color color;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = grid
        ..style = PaintingStyle.stroke,
    );
    final path = Path()..moveTo(0, size.height);
    for (var i = 1; i <= 60; i++) {
      final t = i / 60;
      path.lineTo(t * size.width, size.height * (1 - curve.transform(t)));
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_CurvePainter old) =>
      old.curve != curve || old.color != color;
}
