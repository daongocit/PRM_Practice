/// Exercise 5 – Factory Constructors & Cache
/// Goal: Demonstrate singleton and factory constructor caching patterns in Dart.

// 1. Create a Settings class with a private constructor
class Settings {
  String theme;
  String language;
  bool notificationsEnabled;

  // Single cached instance variable
  static Settings? _instance;

  // Private named constructor
  Settings._internal([
    this.theme = 'Dark',
    this.language = 'English',
    this.notificationsEnabled = true,
  ]);

  // 2. Add a factory constructor Settings() that returns the cached singleton instance
  factory Settings([String? theme, String? language, bool? notificationsEnabled]) {
    if (_instance == null) {
      _instance = Settings._internal(
        theme ?? 'Dark',
        language ?? 'English',
        notificationsEnabled ?? true,
      );
    }
    return _instance!;
  }

  // Optional: Reset singleton instance for testing purposes
  static void reset() {
    _instance = null;
  }

  @override
  String toString() => 'Settings(theme: "$theme", language: "$language", notificationsEnabled: $notificationsEnabled)';
}

/// Helper function to execute Exercise 5 demonstration
void runExercise5() {
  print('==================================================');
  print('--- Exercise 5: Factory Constructors & Cache ---');
  print('==================================================');

  print('Instantiating settings instance "settingsA" using factory constructor Settings()...');
  final settingsA = Settings();
  print('settingsA: $settingsA');

  print('\nInstantiating settings instance "settingsB" using factory constructor Settings()...');
  final settingsB = Settings();
  print('settingsB: $settingsB');

  // Modifying property on settingsA
  print('\nModifying theme property on settingsA to "Light (System Default)"...');
  settingsA.theme = 'Light (System Default)';

  print('Checking settingsB theme value after modifying settingsA:');
  print('settingsB.theme: "${settingsB.theme}"');

  // 3. Verify two instances refer to the exact same memory object using identical(a, b)
  final isSameObject = identical(settingsA, settingsB);

  print('\n--- VERIFICATION RESULT ---');
  print('identical(settingsA, settingsB) -> $isSameObject');

  if (isSameObject) {
    print('SUCCESS: Both references (settingsA & settingsB) point to the EXACT SAME cached singleton instance in memory!');
  } else {
    print('FAILED: Instances are different objects.');
  }

  print('Exercise 5 Completed.\n');
}
