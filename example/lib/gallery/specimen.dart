import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

/// Scrollable page body with a title and intro text.
class GalleryPage extends StatelessWidget {
  const GalleryPage({
    super.key,
    required this.title,
    this.intro,
    required this.children,
  });

  final String title;
  final String? intro;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        NuvioSpace.s32,
        NuvioSpace.s24,
        NuvioSpace.s32,
        NuvioSpace.s64,
      ),
      children: [
        Text(title, style: t.headline.copyWith(color: c.textPrimary)),
        if (intro != null) ...[
          const SizedBox(height: NuvioSpace.s8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              intro!,
              style: t.bodyLg.copyWith(color: c.textSecondary),
            ),
          ),
        ],
        const SizedBox(height: NuvioSpace.sectionGap),
        for (final child in children) ...[
          child,
          const SizedBox(height: NuvioSpace.sectionGap),
        ],
      ],
    );
  }
}

/// One documented item: name, description, live preview, optional knobs and a
/// copyable code snippet.
class Specimen extends StatelessWidget {
  const Specimen({
    super.key,
    required this.title,
    this.description,
    required this.preview,
    this.knobs = const [],
    this.code,
    this.previewPadding = const EdgeInsets.all(NuvioSpace.s24),
    this.artBackground = false,
  });

  final String title;
  final String? description;
  final Widget preview;
  final List<Widget> knobs;
  final String? code;
  final EdgeInsetsGeometry previewPadding;

  /// Shows the preview over the cinematic overlay gradient instead of a flat
  /// background (useful for translucent components).
  final bool artBackground;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    return NuvioSurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              NuvioSpace.cardPadding,
              NuvioSpace.cardPadding,
              NuvioSpace.cardPadding,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: t.titleSm.copyWith(color: c.textPrimary)),
                if (description != null) ...[
                  const SizedBox(height: NuvioSpace.s4),
                  Text(
                    description!,
                    style: t.bodySm.copyWith(color: c.textMuted),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: NuvioSpace.s14),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: NuvioSpace.cardPaddingCompact,
            ),
            padding: previewPadding,
            decoration: BoxDecoration(
              color: artBackground ? null : c.background,
              gradient: artBackground ? c.overlayGradient : null,
              borderRadius: NuvioRadius.all(NuvioRadius.lg),
              border: Border.all(color: c.borderSubtle),
            ),
            child: Material(type: MaterialType.transparency, child: preview),
          ),
          if (knobs.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                NuvioSpace.cardPadding,
                NuvioSpace.s12,
                NuvioSpace.cardPadding,
                0,
              ),
              child: Wrap(
                spacing: NuvioSpace.s16,
                runSpacing: NuvioSpace.s4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: knobs,
              ),
            ),
          if (code != null) CodeBlock(code!),
          const SizedBox(height: NuvioSpace.cardPaddingCompact),
        ],
      ),
    );
  }
}

/// Monospace snippet with a copy button.
class CodeBlock extends StatelessWidget {
  const CodeBlock(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    return Container(
      margin: const EdgeInsets.fromLTRB(
        NuvioSpace.cardPaddingCompact,
        NuvioSpace.s12,
        NuvioSpace.cardPaddingCompact,
        0,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        borderRadius: NuvioRadius.all(NuvioRadius.md),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(
              NuvioSpace.s16,
              NuvioSpace.s12,
              NuvioSpace.s48,
              NuvioSpace.s12,
            ),
            child: SelectableText(
              code.trim(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontFamilyFallback: const ['Menlo', 'Consolas', 'Courier New'],
                fontSize: 12.5,
                height: 1.5,
                color: c.textSecondary,
              ),
            ),
          ),
          Positioned(
            top: NuvioSpace.s4,
            right: NuvioSpace.s4,
            child: IconButton(
              tooltip: 'Copy',
              iconSize: NuvioIconSize.sm,
              color: c.textMuted,
              icon: const Icon(Icons.copy_rounded),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code.trim()));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Copied to clipboard')),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Labelled switch used as a specimen knob.
class BoolKnob extends StatelessWidget {
  const BoolKnob(this.label, this.value, this.onChanged, {super.key});

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Switch(value: value, onChanged: onChanged),
      const SizedBox(width: NuvioSpace.s6),
      Text(
        label,
        style: context.nuvioType.bodySm.copyWith(
          color: context.nuvioColors.textSecondary,
        ),
      ),
    ],
  );
}

/// Labelled slider used as a specimen knob.
class SliderKnob extends StatelessWidget {
  const SliderKnob(
    this.label,
    this.value,
    this.onChanged, {
    super.key,
    this.min = 0,
    this.max = 1,
    this.divisions,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;
  final double min, max;
  final int? divisions;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '$label ${value.toStringAsFixed(2)}',
        style: context.nuvioType.bodySm.copyWith(
          color: context.nuvioColors.textSecondary,
        ),
      ),
      SizedBox(
        width: 200,
        child: Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}

/// Caption under a swatch/box in foundation pages.
class TokenCaption extends StatelessWidget {
  const TokenCaption(this.name, this.value, {super.key});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final t = context.nuvioType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(name, style: t.labelSm.copyWith(color: c.textPrimary)),
        Text(
          value,
          style: t.labelXs.copyWith(
            color: c.textMuted,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

String hex(Color c) =>
    '#${c.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
