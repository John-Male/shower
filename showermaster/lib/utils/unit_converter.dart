import 'package:flutter/material.dart';

class SelectOrAdd extends StatelessWidget {
  final String label;
  final List<String> options;
  final void Function(String) onSelected;
  final Future<void> Function(String) onAdd;

  const SelectOrAdd({
    super.key,
    required this.label,
    required this.options,
    required this.onSelected,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final opt in options)
          ChoiceChip(
            label: Text(opt),
            selected: false,
            onSelected: (_) => onSelected(opt),
          ),
        ActionChip(
          avatar: const Icon(Icons.add),
          label: Text('Add $label'),
          onPressed: () async {
            final controller = TextEditingController();
            final name = await showDialog<String>(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Add $label'),
                content: TextField(controller: controller, autofocus: true),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  FilledButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: const Text('Save')),
                ],
              ),
            );
            if (name != null && name.isNotEmpty) await onAdd(name);
          },
        ),
      ],
    );
  }
}
