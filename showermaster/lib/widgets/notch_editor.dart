import 'package:flutter/material.dart';
import '../utils/unit_converter.dart';
import '../models/user_settings.dart';


class NotchEditor extends StatelessWidget {
  final bool enabled;
  final UnitPreference unit;
  final void Function(bool) onToggle;
  final void Function(String field, double value) onChanged;

  const NotchEditor({
    super.key,
    required this.enabled,
    required this.unit,
    required this.onToggle,
    required this.onChanged,
  });

  String unitLabel() => unit == UnitPreference.mm ? 'mm' : 'in';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text('Bench notch'),
          value: enabled,
          onChanged: (val) => onToggle(val ?? false),
        ),
        if (enabled) ...[
          _buildField('Vertical offset', 'notchVerticalOffsetMm'),
          _buildField('Vertical height', 'notchVerticalHeightMm'),
          _buildField('Horizontal offset', 'notchHorizontalOffsetMm'),
          _buildField('Horizontal depth', 'notchHorizontalDepthMm'),
        ],
      ],
    );
  }

  Widget _buildField(String label, String fieldKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '$label (${unitLabel()})',
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: (val) {
          final raw = double.tryParse(val);
          if (raw != null) {
            final value = unit == UnitPreference.inches ? inchesToMm(raw) : raw;
            onChanged(fieldKey, value);
          }
        },
      ),
    );
  }
}
