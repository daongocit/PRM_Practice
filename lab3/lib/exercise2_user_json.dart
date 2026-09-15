import 'dart:convert';
import 'dart:async';

/// Exercise 2 – User Repository with JSON
/// Goal: Practice JSON serialization and deserialization.

// 1. Create User model with name, email and User.fromJson constructor
class User {
  final String name;
  final String email;

  User({
    required this.name,
    required this.email,
  });

  /// Factory constructor to construct a User instance from a JSON Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'No Email',
    );
  }

  /// Converts User object back to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'User(name: "$name", email: "$email")';
}

// Simulated User API Repository
class UserRepository {
  // 2. Simulate raw JSON string response payload received from a web API
  static const String _rawJsonResponse = '''
  [
    {"name": "Alice Johnson", "email": "alice@example.com"},
    {"name": "Bob Smith", "email": "bob@example.com"},
    {"name": "Charlie Brown", "email": "charlie@example.com"}
  ]
  ''';

  /// 3. Use Future<List<User>> to simulate asynchronous API fetch and parse JSON data
  Future<List<User>> fetchUsers() async {
    // Simulate network delay (400ms)
    await Future.delayed(const Duration(milliseconds: 400));

    // Decode JSON string to dynamic List
    final List<dynamic> jsonList = jsonDecode(_rawJsonResponse) as List<dynamic>;

    // Map each JSON object (Map<String, dynamic>) into a User model instance
    final List<User> users = jsonList
        .map((item) => User.fromJson(item as Map<String, dynamic>))
        .toList();

    return users;
  }
}

/// Helper function to execute Exercise 2 demonstration
Future<void> runExercise2() async {
  print('==================================================');
  print('--- Exercise 2: User Repository with JSON ---');
  print('==================================================');

  final userRepository = UserRepository();

  print('Simulating JSON API request to fetch users...');
  final List<User> users = await userRepository.fetchUsers();

  // 4. Display results using print()
  print('Successfully parsed ${users.length} users from JSON API response:');
  for (int i = 0; i < users.length; i++) {
    print('  [User ${i + 1}] ${users[i]}');
  }

  print('Exercise 2 Completed.\n');
}
