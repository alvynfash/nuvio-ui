import 'package:flutter/material.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    const space = [
      ('s2', NuvioSpace.s2),
      ('s4', NuvioSpace.s4),
      ('s6', NuvioSpace.s6),
      ('s8', NuvioSpace.s8),
      ('s10', NuvioSpace.s10),
      ('s12', NuvioSpace.s12),
      ('s14', NuvioSpace.s14),
      ('s16', NuvioSpace.s16),
      ('s18', NuvioSpace.s18),
      ('s20', NuvioSpace.s20),
      ('s24', NuvioSpace.s24),
      ('s28', NuvioSpace.s28),
      ('s32', NuvioSpace.s32),
      ('s40', NuvioSpace.s40),
      ('s48', NuvioSpace.s48),
      ('s56', NuvioSpace.s56),
      ('s64', NuvioSpace.s64),
      ('s80', NuvioSpace.s80),
      ('s96', NuvioSpace.s96),
    ];
    const semantic = [
      ('screenHorizontal', NuvioSpace.screenHorizontal),
      ('screenTop', NuvioSpace.screenTop),
      ('screenBottom', NuvioSpace.screenBottom),
      ('sectionGap', NuvioSpace.sectionGap),
      ('listGap', NuvioSpace.listGap),
      ('railGap', NuvioSpace.railGap),
      ('cardPadding', NuvioSpace.cardPadding),
      ('cardPaddingCompact', NuvioSpace.cardPaddingCompact),
      ('controlGap', NuvioSpace.controlGap),
      ('dialogPadding', NuvioSpace.dialogPadding),
      ('sheetPadding', NuvioSpace.sheetPadding),
      ('playerOverlayPadding', NuvioSpace.playerOverlayPadding),
    ];
    const radii = [
      ('xs', NuvioRadius.xs),
      ('sm', NuvioRadius.sm),
      ('md', NuvioRadius.md),
      ('lg · poster · compactCard', NuvioRadius.lg),
      ('xl · button', NuvioRadius.xl),
      ('xxl · card · sheet', NuvioRadius.xxl),
      ('dialog', NuvioRadius.dialog),
      ('full · chip · avatar', NuvioRadius.full),
    ];
    const elevation = [
      ('flat', NuvioElevation.flat),
      ('raised', NuvioElevation.raised),
      ('playerControls', NuvioElevation.playerControls),
      ('modal', NuvioElevation.modal),
      ('overlay', NuvioElevation.overlay),
    ];
    const icons = [
      ('xs', NuvioIconSize.xs),
      ('sm', NuvioIconSize.sm),
      ('md', NuvioIconSize.md),
      ('lg', NuvioIconSize.lg),
      ('xl', NuvioIconSize.xl),
      ('xxl', NuvioIconSize.xxl),
    ];
    const opacity = [
      ('subtle', NuvioOpacity.subtle),
      ('hover', NuvioOpacity.hover),
      ('pressed', NuvioOpacity.pressed),
      ('selected', NuvioOpacity.selected),
      ('overlayLight', NuvioOpacity.overlayLight),
      ('disabled', NuvioOpacity.disabled),
      ('medium', NuvioOpacity.medium),
      ('overlayMedium', NuvioOpacity.overlayMedium),
      ('muted', NuvioOpacity.muted),
      ('secondary', NuvioOpacity.secondary),
      ('strong', NuvioOpacity.strong),
      ('overlayHeavy', NuvioOpacity.overlayHeavy),
    ];
    const breakpoints = [
      ('phone', NuvioBreakpoint.phone),
      ('largePhone', NuvioBreakpoint.largePhone),
      ('tablet', NuvioBreakpoint.tablet),
      ('largeTablet', NuvioBreakpoint.largeTablet),
      ('desktop', NuvioBreakpoint.desktop),
      ('playerWide', NuvioBreakpoint.playerWide),
    ];
    final width = MediaQuery.sizeOf(context).width;

    Widget bar(String name, double v) => Padding(
      padding: const EdgeInsets.symmetric(vertical: NuvioSpace.s4),
      child: Row(
        children: [
          SizedBox(width: 190, child: TokenCaption(name, '${_n(v)} px')),
          Container(
            width: v * 3,
            height: NuvioSpace.s12,
            decoration: BoxDecoration(
              gradient: c.accentGradient,
              borderRadius: NuvioRadius.all(NuvioRadius.xs),
            ),
          ),
        ],
      ),
    );

    return GalleryPage(
      title: 'Spacing & shape',
      intro:
          'All sizes are logical pixels. Prefer the semantic names; the numeric '
          'scale is there for one-off layout.',
      children: [
        Specimen(
          title: 'Space scale (NuvioSpace.sN)',
          preview: Column(children: [for (final (n, v) in space) bar(n, v)]),
          code:
              'Padding(padding: const EdgeInsets.all(NuvioSpace.s16), child: ...)',
        ),
        Specimen(
          title: 'Semantic spacing',
          preview: Column(children: [for (final (n, v) in semantic) bar(n, v)]),
          code: 'const SizedBox(height: NuvioSpace.sectionGap)',
        ),
        Specimen(
          title: 'Radius (NuvioRadius)',
          preview: Wrap(
            spacing: NuvioSpace.s20,
            runSpacing: NuvioSpace.s20,
            children: [
              for (final (n, v) in radii)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      height: 72,
                      decoration: BoxDecoration(
                        color: c.surfaceCard,
                        borderRadius: NuvioRadius.all(v),
                        border: Border.all(color: c.borderStrong),
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.s6),
                    TokenCaption(n, '${_n(v)} px'),
                  ],
                ),
            ],
          ),
          code: 'BorderRadius: NuvioRadius.all(NuvioRadius.card)',
        ),
        Specimen(
          title: 'Elevation & borders',
          preview: Wrap(
            spacing: NuvioSpace.s24,
            runSpacing: NuvioSpace.s24,
            children: [
              for (final (n, v) in elevation)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: c.surfaceElevated,
                      elevation: v,
                      shadowColor: Colors.black,
                      borderRadius: NuvioRadius.all(NuvioRadius.lg),
                      child: const SizedBox(width: 96, height: 64),
                    ),
                    const SizedBox(height: NuvioSpace.s8),
                    TokenCaption(n, _n(v)),
                  ],
                ),
              for (final (n, v) in const [
                ('hairline', NuvioBorderWidth.hairline),
                ('thin', NuvioBorderWidth.thin),
                ('medium', NuvioBorderWidth.medium),
              ])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: NuvioRadius.all(NuvioRadius.lg),
                        border: Border.all(color: c.textSecondary, width: v),
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.s8),
                    TokenCaption('border.$n', '${_n(v)} px'),
                  ],
                ),
            ],
          ),
        ),
        Specimen(
          title: 'Icon sizes (NuvioIconSize)',
          preview: Wrap(
            spacing: NuvioSpace.s24,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              for (final (n, v) in icons)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_circle_rounded, size: v, color: c.accent),
                    const SizedBox(height: NuvioSpace.s6),
                    TokenCaption(n, '${_n(v)} px'),
                  ],
                ),
            ],
          ),
          code: 'Icon(Icons.play_arrow, size: NuvioIconSize.lg)',
        ),
        Specimen(
          title: 'Opacity (NuvioOpacity)',
          description:
              'Applied to the accent here; Nuvio uses these on white/black/accent.',
          preview: Wrap(
            spacing: NuvioSpace.s12,
            runSpacing: NuvioSpace.s12,
            children: [
              for (final (n, v) in opacity)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 88,
                      height: 48,
                      decoration: BoxDecoration(
                        color: c.accent.withValues(alpha: v),
                        borderRadius: NuvioRadius.all(NuvioRadius.md),
                      ),
                    ),
                    const SizedBox(height: NuvioSpace.s4),
                    TokenCaption(n, '$v'),
                  ],
                ),
            ],
          ),
          code: 'c.accent.withValues(alpha: NuvioOpacity.selected)',
        ),
        Specimen(
          title: 'Breakpoints (NuvioBreakpoint)',
          description: 'This window is ${width.round()} px wide.',
          preview: Wrap(
            spacing: NuvioSpace.s8,
            runSpacing: NuvioSpace.s8,
            children: [
              for (final (n, v) in breakpoints)
                NuvioChip(
                  label: '$n ≥ ${_n(v)}',
                  selected: width >= v,
                  onTap: null,
                ),
            ],
          ),
          code: '''
final wide = MediaQuery.sizeOf(context).width >= NuvioBreakpoint.largeTablet;
// Desktop UI scale used by Nuvio:
final scale = NuvioThemeData.desktopUiScale(MediaQuery.sizeOf(context));
''',
        ),
      ],
    );
  }
}

String _n(double v) =>
    v == v.roundToDouble() ? v.round().toString() : v.toString();
