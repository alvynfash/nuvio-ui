## 0.1.1

Documentation only; no API changes.

- README: hero screenshot, a screenshot gallery of all component groups, a
  runnable example, and a links section (repository, issues, API docs).
- pub.dev: 10 listing screenshots (`screenshots:` in `pubspec.yaml`).
- Example tab: `example/README.md` now walks through a complete quick-start
  app (`example/lib/quick_start.dart`) plus the full gallery.
- `tool/update_screenshots.sh` regenerates the screenshots from the gallery
  (macOS), via an opt-in render test with real fonts.

## 0.1.0

First release.

- Design tokens: `NuvioSpace`, `NuvioRadius`, `NuvioElevation`, `NuvioBorderWidth`,
  `NuvioIconSize`, `NuvioMotion`, `NuvioOpacity`, `NuvioBreakpoint`, `NuvioComponent`.
- 12 accent palettes (`NuvioPalette.all`) and semantic colours (`NuvioColors`).
- Type ramp (`NuvioTypeScale`) with bundled JetBrains Sans as the default font.
- `NuvioThemeData.build`: a dark Material 3 theme that also styles buttons,
  switches, radios, checkboxes, sliders (gradient track), text fields, tabs,
  menus, tooltips, list tiles, cards, dialogs, sheets and snackbars.
- Widgets: buttons, chips and pills, dropdown chip, badges, cards, glass panel,
  list card, dialogs, bottom sheets, menu items, toasts, option tiles, settings
  rows and sidebar items, progress bar, loading indicator, skeleton, status
  banner, empty state and resume prompt.
- Example app: a widget-book-style gallery of every token and component.
