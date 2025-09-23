enum UnitPreference { mm, inches }

class UserSettings {
  final String id;
  final UnitPreference unitPreference;

  UserSettings({required this.id, required this.unitPreference});
}
