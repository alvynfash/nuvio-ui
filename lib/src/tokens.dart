// Primitive and semantic design tokens. All sizes are logical pixels.

import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

/// Spacing scale (`s1`–`s96`) and semantic spacing.
abstract final class NuvioSpace {
  /// No space.
  static const double none = 0;

  /// Half a pixel, for hairline gaps.
  static const double hairline = 0.5;

  /// 1 px.
  static const double s1 = 1;

  /// 2 px.
  static const double s2 = 2;

  /// 3 px.
  static const double s3 = 3;

  /// 4 px.
  static const double s4 = 4;

  /// 5 px.
  static const double s5 = 5;

  /// 6 px.
  static const double s6 = 6;

  /// 7 px.
  static const double s7 = 7;

  /// 8 px.
  static const double s8 = 8;

  /// 10 px.
  static const double s10 = 10;

  /// 12 px.
  static const double s12 = 12;

  /// 14 px.
  static const double s14 = 14;

  /// 16 px.
  static const double s16 = 16;

  /// 18 px.
  static const double s18 = 18;

  /// 20 px.
  static const double s20 = 20;

  /// 22 px.
  static const double s22 = 22;

  /// 24 px.
  static const double s24 = 24;

  /// 28 px.
  static const double s28 = 28;

  /// 32 px.
  static const double s32 = 32;

  /// 36 px.
  static const double s36 = 36;

  /// 40 px.
  static const double s40 = 40;

  /// 48 px.
  static const double s48 = 48;

  /// 56 px.
  static const double s56 = 56;

  /// 64 px.
  static const double s64 = 64;

  /// 72 px.
  static const double s72 = 72;

  /// 80 px.
  static const double s80 = 80;

  /// 96 px.
  static const double s96 = 96;

  // Semantic spacing
  /// Horizontal page padding. (16 px)
  static const double screenHorizontal = s16;

  /// Top page padding. (10 px)
  static const double screenTop = s10;

  /// Bottom page padding. (18 px)
  static const double screenBottom = s18;

  /// Gap between page sections. (24 px)
  static const double sectionGap = s24;

  /// Gap between items in a list. (12 px)
  static const double listGap = s12;

  /// Gap between cards in a horizontal rail. (14 px)
  static const double railGap = s14;

  /// Inner padding of cards. (18 px)
  static const double cardPadding = s18;

  /// Inner padding of compact cards. (14 px)
  static const double cardPaddingCompact = s14;

  /// Gap between adjacent controls. (8 px)
  static const double controlGap = s8;

  /// Inner padding of dialogs. (20 px)
  static const double dialogPadding = s20;

  /// Inner padding of bottom sheets. (20 px)
  static const double sheetPadding = s20;

  /// Padding of video-player overlays. (24 px)
  static const double playerOverlayPadding = s24;
}

/// Corner radius scale and semantic radii.
abstract final class NuvioRadius {
  /// Square corners.
  static const double none = 0;

  /// 4 px.
  static const double xs = 4;

  /// 6 px.
  static const double sm = 6;

  /// 8 px.
  static const double md = 8;

  /// 12 px.
  static const double lg = 12;

  /// 16 px.
  static const double xl = 16;

  /// 24 px.
  static const double xxl = 24;

  /// Fully rounded (pill / circle).
  static const double full = 999;

  // Semantic radii
  /// Cards (24 px).
  static const double card = xxl;

  /// Compact cards, menu items and sheet rows (12 px).
  static const double compactCard = lg;

  /// Bottom sheets (24 px).
  static const double sheet = xxl;

  /// Dialogs (28 px).
  static const double dialog = 28;

  /// Buttons (16 px).
  static const double button = xl;

  /// Pills and badges (fully rounded).
  static const double chip = full;

  /// Posters and artwork (12 px).
  static const double poster = lg;

  /// Avatars (circle).
  static const double avatar = full;

  /// Video-player side panels (24 px).
  static const double playerPanel = xxl;

  /// Shorthand for a uniform [BorderRadius] of [r].
  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));
}

/// Border widths.
abstract final class NuvioBorderWidth {
  /// Hairline dividers and outlines (0.5 px).
  static const double hairline = 0.5;

  /// Standard outlines (1 px).
  static const double thin = 1;

  /// Emphasised outlines and focus rings (2 px).
  static const double medium = 2;
}

/// Material elevation levels.
abstract final class NuvioElevation {
  /// Flush with the page.
  static const double flat = 0;

  /// Slightly raised surfaces.
  static const double raised = 2;

  /// Video-player controls.
  static const double playerControls = 4;

  /// Dialogs, menus and floating prompts.
  static const double modal = 8;

  /// Toasts and top-most overlays.
  static const double overlay = 12;
}

/// Icon sizes.
abstract final class NuvioIconSize {
  /// 12 px.
  static const double xs = 12;

  /// 16 px.
  static const double sm = 16;

  /// 20 px.
  static const double md = 20;

  /// 24 px.
  static const double lg = 24;

  /// 32 px.
  static const double xl = 32;

  /// 40 px.
  static const double xxl = 40;
}

/// Layout breakpoints: the minimum window width for each class.
abstract final class NuvioBreakpoint {
  /// Phones (any width).
  static const double phone = 0;

  /// Large phones (≥ 420 px).
  static const double largePhone = 420;

  /// Tablets (≥ 600 px).
  static const double tablet = 600;

  /// Large tablets; side navigation fits (≥ 840 px).
  static const double largeTablet = 840;

  /// Desktop windows (≥ 1024 px).
  static const double desktop = 1024;

  /// Wide video-player layouts (≥ 1280 px).
  static const double playerWide = 1280;
}

/// Animation durations and easing curves.
abstract final class NuvioMotion {
  /// No animation.
  static const instant = Duration.zero;

  /// 150 ms: hovers, presses, small toggles.
  static const fast = Duration(milliseconds: 150);

  /// 220 ms: most transitions.
  static const normal = Duration(milliseconds: 220);

  /// 300 ms: sheets sliding in.
  static const sheetEnter = Duration(milliseconds: 300);

  /// 250 ms: sheets sliding out.
  static const sheetExit = Duration(milliseconds: 250);

  /// 400 ms: larger layout changes.
  static const slow = Duration(milliseconds: 400);

  /// 700 ms: hero and artwork transitions.
  static const cinematic = Duration(milliseconds: 700);

  /// Default easing for most motion.
  static const Curve standard = Cubic(0.2, 0, 0, 1);

  /// Easing for prominent, expressive motion.
  static const Curve emphasized = Cubic(0.2, 0, 0, 1);

  /// Elements entering the screen.
  static const Curve decelerate = Cubic(0, 0, 0, 1);

  /// Elements leaving the screen.
  static const Curve accelerate = Cubic(0.3, 0, 1, 1);
}

/// Opacity levels for overlays, states and de-emphasis.
abstract final class NuvioOpacity {
  /// Fully transparent.
  static const double invisible = 0;

  /// Skeletons and faint fills.
  static const double subtle = 0.06;

  /// Hover state overlay.
  static const double hover = 0.08;

  /// Pressed state overlay.
  static const double pressed = 0.12;

  /// Selected state overlay.
  static const double selected = 0.15;

  /// Light scrims and text selection.
  static const double overlayLight = 0.35;

  /// Disabled content.
  static const double disabled = 0.38;

  /// Medium emphasis.
  static const double medium = 0.52;

  /// Modal scrims.
  static const double overlayMedium = 0.56;

  /// Muted content.
  static const double muted = 0.6;

  /// Secondary content.
  static const double secondary = 0.7;

  /// Strong emphasis.
  static const double strong = 0.75;

  /// Heavy scrims.
  static const double overlayHeavy = 0.82;

  /// Fully opaque.
  static const double visible = 1;
}

/// Fixed component sizes.
abstract final class NuvioComponent {
  /// Corner radius of navigation items.
  static const double navItemRadius = NuvioRadius.xl;

  /// Icon size in navigation items.
  static const double navIconSize = NuvioIconSize.xl;

  /// Maximum width of a navigation item.
  static const double navItemMaxWidth = 150;

  /// Maximum width of bottom sheets, toasts and prompts.
  static const double sheetMaxWidth = 520;

  /// Maximum width of dialogs.
  static const double dialogMaxWidth = 460;

  /// Horizontal chip padding.
  static const double chipHorizontalPadding = NuvioSpace.s14;

  /// Vertical chip padding.
  static const double chipVerticalPadding = NuvioSpace.s8;

  /// Avatar diameter.
  static const double avatarSize = NuvioSpace.s48;

  /// Maximum width of video-player side panels.
  static const double playerPanelMaxWidth = 600;

  /// Height of `NuvioFilterPill`.
  static const double filterPillHeight = 36;

  /// Aspect ratio of landscape (backdrop) posters.
  static const double posterLandscapeAspectRatio = 1.77;

  /// Poster scale factor on desktop catalogs.
  static const double desktopCatalogPosterScale = 1.4;
}
