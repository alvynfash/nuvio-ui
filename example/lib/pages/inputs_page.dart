import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nuvio_ui/nuvio_ui.dart';

import '../gallery/specimen.dart';

class InputsPage extends HookWidget {
  const InputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.nuvioColors;
    final on = useState(true);
    final enabled = useState(true);
    final radio = useState('auto');
    final check = useState<bool?>(true);
    final slider = useState(0.6);
    final stepped = useState(3.0);
    final text = useTextEditingController();
    final option = useState('1080p');

    return GalleryPage(
      title: 'Inputs & selection',
      intro:
          'Switches, radios, checkboxes, sliders and text fields are stock '
          'Material widgets. The theme gives them Nuvio’s look, so nothing extra '
          'needs importing.',
      children: [
        Specimen(
          title: 'Switch',
          description:
              'Accent track with onAccent thumb when on; muted thumb on the border colour when off.',
          knobs: [BoolKnob('enabled', enabled.value, (v) => enabled.value = v)],
          preview: Wrap(
            spacing: NuvioSpace.s24,
            children: [
              Switch(
                value: on.value,
                onChanged: enabled.value ? (v) => on.value = v : null,
              ),
              Switch(
                value: !on.value,
                onChanged: enabled.value ? (v) => on.value = !v : null,
              ),
            ],
          ),
          code: 'Switch(value: on, onChanged: (v) => setState(() => on = v))',
        ),
        Specimen(
          title: 'Radio & NuvioOptionTile',
          description:
              'Nuvio prefers option tiles (accent tint + check) over bare radios; both are themed.',
          preview: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RadioGroup<String>(
                  groupValue: radio.value,
                  onChanged: (v) => radio.value = v!,
                  child: const Column(
                    children: [
                      RadioListTile(value: 'auto', title: Text('Automatic')),
                      RadioListTile(
                        value: 'manual',
                        title: Text('Ask every time'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: NuvioSpace.s24),
              Expanded(
                child: Column(
                  children: [
                    for (final (v, label, sub) in const [
                      ('2160p', '4K', 'Best quality, needs fast internet'),
                      ('1080p', '1080p', 'Recommended'),
                      ('720p', '720p', 'Saves data'),
                    ])
                      NuvioOptionTile(
                        title: label,
                        subtitle: sub,
                        selected: option.value == v,
                        onTap: () => option.value = v,
                      ),
                  ],
                ),
              ),
            ],
          ),
          code: '''
NuvioOptionTile(
  title: '1080p',
  subtitle: 'Recommended',
  selected: quality == '1080p',
  onTap: () => setState(() => quality = '1080p'),
)
''',
        ),
        Specimen(
          title: 'Checkbox',
          description:
              'Nuvio has no checkboxes; the theme styles them to match radios.',
          preview: Row(
            children: [
              Checkbox(
                tristate: true,
                value: check.value,
                onChanged: (v) => check.value = v,
              ),
              Text('Include specials', style: TextStyle(color: c.textPrimary)),
            ],
          ),
          code:
              'Checkbox(value: checked, onChanged: (v) => setState(() => checked = v!))',
        ),
        Specimen(
          title: 'Slider',
          description:
              '4 px track filled with the palette gradient, 20 px thumb.',
          preview: Column(
            children: [
              Slider(value: slider.value, onChanged: (v) => slider.value = v),
              Slider(
                value: stepped.value,
                min: 0,
                max: 5,
                divisions: 5,
                label: '${stepped.value.round()}',
                onChanged: (v) => stepped.value = v,
              ),
            ],
          ),
          code: 'Slider(value: v, onChanged: (x) => setState(() => v = x))',
        ),
        Specimen(
          title: 'Text field',
          description:
              'Card fill, accent cursor, focus-ring outline (NuvioInputField).',
          preview: Column(
            children: [
              TextField(
                controller: text,
                decoration: const InputDecoration(
                  hintText: 'Search movies & shows',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: NuvioSpace.s12),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'API key',
                  hintText: 'Paste your key',
                ),
              ),
            ],
          ),
          code: '''
TextField(
  decoration: InputDecoration(
    hintText: 'Search movies & shows',
    prefixIcon: Icon(Icons.search_rounded),
  ),
)
''',
        ),
      ],
    );
  }
}
