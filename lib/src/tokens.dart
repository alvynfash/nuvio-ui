// Primitive and semantic scales recovered from Nuvio desktop 1.1.36
// (com.nuvio.app.core.ui.NuvioTokens + defaultNuvioThemeTokens).
// Compose dp == Flutter logical px.

import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

abstract final class NuvioSpace {
  static const double none = 0, hairline = 0.5;
  static const double s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6, s7 = 7;
  static const double s8 = 8, s10 = 10, s12 = 12, s14 = 14, s16 = 16, s18 = 18;
  static const double s20 = 20, s22 = 22, s24 = 24, s28 = 28, s32 = 32;
  static const double s36 = 36, s40 = 40, s48 = 48, s56 = 56, s64 = 64;
  static const double s72 = 72, s80 = 80, s96 = 96;

  // Semantic spacing (NuvioSpacingTokens)
  static const double screenHorizontal = s16;
  static const double screenTop = s10;
  static const double screenBottom = s18;
  static const double sectionGap = s24;
  static const double listGap = s12;
  static const double railGap = s14;
  static const double cardPadding = s18;
  static const double cardPaddingCompact = s14;
  static const double controlGap = s8;
  static const double dialogPadding = s20;
  static const double sheetPadding = s20;
  static const double playerOverlayPadding = s24;
}

abstract final class NuvioRadius {
  static const double none = 0, xs = 4, sm = 6, md = 8, lg = 12, xl = 16;
  static const double xxl = 24, full = 999;

  // Semantic radii (NuvioShapeTokens)
  static const double card = xxl;
  static const double compactCard = lg;
  static const double sheet = xxl;
  static const double dialog = 28;
  static const double button = xl;
  static const double chip = full;
  static const double poster = lg;
  static const double avatar = full;
  static const double playerPanel = xxl;

  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));
}

abstract final class NuvioBorderWidth {
  static const double hairline = 0.5, thin = 1, medium = 2;
}

abstract final class NuvioElevation {
  static const double flat = 0, raised = 2, playerControls = 4, modal = 8;
  static const double overlay = 12;
}

abstract final class NuvioIconSize {
  static const double xs = 12, sm = 16, md = 20, lg = 24, xl = 32, xxl = 40;
}

abstract final class NuvioBreakpoint {
  static const double phone = 0, largePhone = 420, tablet = 600;
  static const double largeTablet = 840, desktop = 1024, playerWide = 1280;
}

abstract final class NuvioMotion {
  static const instant = Duration.zero;
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 220);
  static const sheetEnter = Duration(milliseconds: 300);
  static const sheetExit = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);
  static const cinematic = Duration(milliseconds: 700);

  static const Curve standard = Cubic(0.2, 0, 0, 1);
  static const Curve emphasized = Cubic(0.2, 0, 0, 1);
  static const Curve decelerate = Cubic(0, 0, 0, 1);
  static const Curve accelerate = Cubic(0.3, 0, 1, 1);
}

abstract final class NuvioOpacity {
  static const double invisible = 0, subtle = 0.06, hover = 0.08;
  static const double pressed = 0.12, selected = 0.15, overlayLight = 0.35;
  static const double disabled = 0.38, medium = 0.52, overlayMedium = 0.56;
  static const double muted = 0.6, secondary = 0.7, strong = 0.75;
  static const double overlayHeavy = 0.82, visible = 1;
}

/// Fixed component sizes (NuvioComponentTokens and screen-level constants).
abstract final class NuvioComponent {
  static const double navItemRadius = NuvioRadius.xl;
  static const double navIconSize = NuvioIconSize.xl;
  static const double navItemMaxWidth = 150;
  static const double sheetMaxWidth = 520;
  static const double dialogMaxWidth = 460;
  static const double chipHorizontalPadding = NuvioSpace.s14;
  static const double chipVerticalPadding = NuvioSpace.s8;
  static const double avatarSize = NuvioSpace.s48;
  static const double playerPanelMaxWidth = 600;
  static const double filterPillHeight = 36;

  static const double posterLandscapeAspectRatio = 1.77;
  static const double desktopCatalogPosterScale = 1.4;
}
