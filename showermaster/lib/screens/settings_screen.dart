import 'package:flutter/material.dart';
import '../models/user_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UnitPreference _unit = UnitPreference.mm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Measurement Units', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Millimeters (mm)'),
              leading: Radio<UnitPreference>(
                value: UnitPreference.mm,
                groupValue: _unit,
                onChanged: (val) => setState(() => _unit = val!),
              ),
            ),
            ListTile(
              title: const Text('Inches (in)'),
              leading: Radio<UnitPreference>(
                value: UnitPreference.inches,
                groupValue: _unit,
                onChanged: (val) => setState(() => _unit = val!),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Save unit preference to persistent storage
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
