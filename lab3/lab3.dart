import 'dart:async';
import 'dart:convert';

/// ============================================================================
/// LAB 3 – ADVANCED DART PRACTICE EXERCISES (All-in-one / DartPad Compatible)
/// ============================================================================
/// 
/// This file contains all 5 exercises and can be executed directly in Android Studio,
/// VS Code, or copied directly into DartPad (https://dartpad.dev).
/// 

Future<void> main() async {
  print('******************************************************************');
  print('            LAB 3: ADVANCED DART PRACTICE EXERCISES              ');
  print('******************************************************************\n');

  // Exercise 1: Product Model & Repository
  await runExercise1();

  // Exercise 2: User Repository with JSON
  await runExercise2();

  // Exercise 3: Async + Microtask Debugging
  await runExercise3();

  // Exercise 4: Stream Transformation
  await runExercise4();

  // Exercise 5: Factory Constructors & Cache
  runExercise5();

  print('******************************************************************');
  print('        ALL 5 LAB 3 EXERCISES COMPLETED SUCCESSFULLY!            ');
  print('******************************************************************');
}

// ============================================================================
// EXERCISE 1 – PRODUCT MODEL & REPOSITORY
// ============================================================================

class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$${price.toStringAsFixed(2)})';
}

class ProductRepository {
  final List<Product> _products = [
    Product(id: 'P01', name: 'Laptop Pro', price: 1299.99),
    Product(id: 'P02', name: 'Wireless Mouse', price: 29.99),
    Product(id: 'P03', name: 'Mechanical Keyboard', price: 89.99),
  ];

  final StreamController<Product> _liveAddedController = StreamController<Product>.broadcast();

  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_products);
  }

  Stream<Product> get liveAdded => _liveAddedController.stream;

  void addProduct(Product product) {
    _products.add(product);
    _liveAddedController.add(product);
  }

  void dispose() {
    _liveAddedController.close();
  }
}

Future<void> runExercise1() async {
  print('==================================================');
  print('--- Exercise 1: Product Model & Repository ---');
  print('==================================================');

  final repository = ProductRepository();

  final subscription = repository.liveAdded.listen((product) {
    print('[STREAM EVENT] Live product added: $product');
  });

  print('Fetching all existing products asynchronously...');
  final initialProducts = await repository.getAll();
  print('Fetched ${initialProducts.length} products:');
  for (final p in initialProducts) {
    print('  - $p');
  }

  print('\nAdding new products to trigger live broadcast stream events...');
  await Future.delayed(const Duration(milliseconds: 300));
  repository.addProduct(Product(id: 'P04', name: '4K Monitor', price: 349.50));

  await Future.delayed(const Duration(milliseconds: 300));
  repository.addProduct(Product(id: 'P05', name: 'USB-C Dock', price: 75.00));

  await Future.delayed(const Duration(milliseconds: 200));
  await subscription.cancel();
  repository.dispose();
  print('Exercise 1 Completed.\n');
}

// ============================================================================
// EXERCISE 2 – USER REPOSITORY WITH JSON
// ============================================================================

class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'No Email',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'User(name: "$name", email: "$email")';
}

class UserRepository {
  static const String _rawJsonResponse = '''
  [
    {"name": "Alice Johnson", "email": "alice@example.com"},
    {"name": "Bob Smith", "email": "bob@example.com"},
    {"name": "Charlie Brown", "email": "charlie@example.com"}
  ]
  ''';

  Future<List<User>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final List<dynamic> jsonList = jsonDecode(_rawJsonResponse) as List<dynamic>;
    return jsonList
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

Future<void> runExercise2() async {
  print('==================================================');
  print('--- Exercise 2: User Repository with JSON ---');
  print('==================================================');

  final userRepository = UserRepository();

  print('Simulating JSON API request to fetch users...');
  final List<User> users = await userRepository.fetchUsers();

  print('Successfully parsed ${users.length} users from JSON API response:');
  for (int i = 0; i < users.length; i++) {
    print('  [User ${i + 1}] ${users[i]}');
  }

  print('Exercise 2 Completed.\n');
}

// ============================================================================
// EXERCISE 3 – ASYNC + MICROTASK DEBUGGING
// ============================================================================

Future<void> runExercise3() async {
  print('==================================================');
  print('--- Exercise 3: Async + Microtask Debugging ---');
  print('==================================================');

  final completer = Completer<void>();

  print('1. [Synchronous] Start of main execution thread');

  Future(() {
    print('4. [Event Queue] Callback from Future() executed');
    completer.complete();
  });

  Future.delayed(const Duration(milliseconds: 10), () {
    print('5. [Event Queue] Callback from Future.delayed() executed');
  });

  scheduleMicrotask(() {
    print('3. [Microtask Queue] Callback from scheduleMicrotask() executed');
  });

  print('2. [Synchronous] End of main execution thread');

  /*
   * EXPLANATION:
   * Dart's Event Loop prioritizes the Microtask Queue over the Event Queue.
   * When synchronous code finishes executing, Dart drains ALL microtasks in the
   * Microtask Queue before pulling the next event callback from the Event Queue.
   */

  print('\n-- Waiting for asynchronous event queue callbacks to finish --');
  await completer.future;
  await Future.delayed(const Duration(milliseconds: 20));
  print('Exercise 3 Completed.\n');
}

// ============================================================================
// EXERCISE 4 – STREAM TRANSFORMATION
// ============================================================================

Future<void> runExercise4() async {
  print('==================================================');
  print('--- Exercise 4: Stream Transformation ---');
  print('==================================================');

  final Stream<int> rawNumberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Original input stream numbers: [1, 2, 3, 4, 5]');

  final Stream<int> processedStream = rawNumberStream
      .map((number) {
        final squared = number * number;
        print('  [MAP] Squaring $number -> $squared');
        return squared;
      })
      .where((squaredNumber) {
        final isEven = squaredNumber % 2 == 0;
        print('  [WHERE] Checking if $squaredNumber is even -> $isEven');
        return isEven;
      });

  print('\nListening to transformed stream output (emits squared EVEN numbers only):');

  final completer = Completer<void>();

  processedStream.listen(
    (value) {
      print('>>> [EMITTED VALUE] Output: $value');
    },
    onDone: () {
      print('\nStream finished emitting all items.');
      completer.complete();
    },
  );

  await completer.future;
  print('Exercise 4 Completed.\n');
}

// ============================================================================
// EXERCISE 5 – FACTORY CONSTRUCTORS & CACHE
// ============================================================================

class Settings {
  String theme;
  String language;
  bool notificationsEnabled;

  static Settings? _instance;

  Settings._internal([
    this.theme = 'Dark',
    this.language = 'English',
    this.notificationsEnabled = true,
  ]);

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

  @override
  String toString() => 'Settings(theme: "$theme", language: "$language", notificationsEnabled: $notificationsEnabled)';
}

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

  print('\nModifying theme property on settingsA to "Light (System Default)"...');
  settingsA.theme = 'Light (System Default)';

  print('Checking settingsB theme value after modifying settingsA:');
  print('settingsB.theme: "${settingsB.theme}"');

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
