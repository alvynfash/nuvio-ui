# nuvio_design

A dark, cinematic Flutter design system modelled on the **Nuvio** desktop app
(v1.1.36, Kotlin Compose Multiplatform). Every token below was recovered from
the shipped bytecode (`com.nuvio.app.core.ui`). Nothing here is guessed from
screenshots unless marked *approx.*

It has no dependencies beyond Flutter. It needs Flutter ≥ 3.29 and Dart ≥ 3.7.

## Install

```yaml
dependencies:
  nuvio_design:
    path: ../nuvio-design-system   # or a git URL once you push it
```

```dart
import 'package:nuvio_design/nuvio_design.dart';

MaterialApp(
  theme: NuvioThemeData.build(
    NuvioPalette.arcticBlue,   // 12 built-in palettes, see NuvioPalette.all
    amoled: false,             // true = pure-black background
    fontFamily: 'Inter',       // any font your app bundles; null = platform
  ),
);

// In any widget:
final c = context.nuvioColors;   // semantic colours (43 roles)
final t = context.nuvioType;     // Nuvio type ramp
Text('Hello', style: t.titleMd.copyWith(color: c.textPrimary));
```

Stock Material widgets such as `FilledButton`, `Card`, `Dialog`, `Chip`,
`TextField`, bottom sheets and snackbars pick up the theme automatically. The
`Nuvio*` widgets cover the patterns Material does not provide.

## What's inside

| Layer | API | Source in Nuvio |
|---|---|---|
| Spacing | `NuvioSpace.s4 … s96`, semantic `screenHorizontal`, `cardPadding`, … | `NuvioTokens.Space`, `NuvioSpacingTokens` |
| Radius | `NuvioRadius.xs 4 · sm 6 · md 8 · lg 12 · xl 16 · xxl 24 · full`, semantic `card 24`, `dialog 28`, `button 16`, `poster 12` | `NuvioTokens.Radius` |
| Borders / elevation / icons | `NuvioBorderWidth`, `NuvioElevation`, `NuvioIconSize` | same-named objects |
| Motion | `NuvioMotion.fast 150ms · normal 220 · slow 400 · cinematic 700`, curves `standard = Cubic(0.2,0,0,1)` | `NuvioMotionTokens` |
| Opacity | `NuvioOpacity.hover .08 · pressed .12 · selected .15 · disabled .38 …` | `NuvioOpacityTokens` |
| Breakpoints | `largePhone 420 · tablet 600 · largeTablet 840 · desktop 1024 · playerWide 1280` | `NuvioTokens.Breakpoint` |
| Palettes | Gold, Jade, Rose Gold, Arctic Blue, Graphite (gradient accents), Crimson, Ocean, Violet, Emerald, Amber, Rose, White | `ThemeColors` |
| Colours | `NuvioColors` ThemeExtension: surfaces, text, accent, borders, status, overlays, player | `NuvioColorTokens` |
| Type | `NuvioTypeScale` ThemeExtension (`labelXs 11 … displayMd 48`) plus Material `TextTheme` overrides | `NuvioTokens.Type/LineHeight/LetterSpacing` |
| Widgets | `NuvioPrimaryButton`, `NuvioCircleIconButton`, `NuvioChip`, `NuvioFilterPill`, `NuvioSurfaceCard`, `NuvioGlassPanel`, `NuvioListCard`, `NuvioSectionLabel`, `NuvioProgressBar`, `NuvioInfoBadge`, `NuvioStatusBanner`, `NuvioSkeleton`, `NuvioPressScale` | `Components.kt`, `Chip.kt`, `ProviderFilterRow.kt`, `StreamCard.kt`, … |

The fixed colours shared by every palette are:

- Text: primary `#F5F7F8`, secondary `#B8BEC5`, muted `#969CA3`, inverse `#111111`
- Borders: default `#252A2A`, strong `#3A4040`
- Status: success `#66BB6A`, warning `#FFC857`, danger `#E36A8A`, info `#42A5F5`

## Desktop scaling

Nuvio scales its whole UI on desktop by `clamp(min(w/1280, h/820), 1.0, 1.18)`
and adds a 1.08 text scale. Both are exposed as
`NuvioThemeData.desktopUiScale(size)` and `NuvioThemeData.desktopFontScale` if
you want the same feel.

## Hooks?

Not needed. The package is tokens plus stateless widgets. The only state is
`NuvioPressScale`, which tracks one bool, and the `NuvioSkeleton` animation
ticker, both kept private inside the package. Your app can use `flutter_hooks`
on top of it, or skip hooks entirely.

## Font

Nuvio bundles **JetBrains Sans**. Its embedded licence reads "All rights
reserved", so it is not included here. Inter is the closest free substitute.

## Example

```sh
cd example && flutter create . --platforms=macos,windows,linux && flutter run
```
