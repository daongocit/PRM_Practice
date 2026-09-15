// =============================================================================
// LAB 2 – DART ESSENTIALS PRACTICE LAB
// File: lab2.dart
// Description: Complete solution for Lab 2 covering Dart fundamentals:
//              Ex 1: Basic Syntax & Data Types
//              Ex 2: Collections & Operators
//              Ex 3: Control Flow & Functions
//              Ex 4: Intro to OOP
//              Ex 5: Async, Future, Null Safety & Streams
// =============================================================================

import 'dart:async';

// -----------------------------------------------------------------------------
// EXERCISE 4: CLASSES & INHERITANCE DEFINITIONS
// -----------------------------------------------------------------------------

/// Base Class Car with property, default constructor, named constructor, and method
class Car {
  // 1. Property
  String brand;
  int speed;

  // Standard positional / generative constructor
  Car(this.brand, [this.speed = 0]);

  // 2. Named constructor
  Car.withBrand(this.brand) : speed = 60;

  // Method to display car info
  void displayInfo() {
    print('Car Brand: $brand, Speed: ${speed} km/h');
  }
}

/// 3. Subclass ElectricCar overriding displayInfo method
class ElectricCar extends Car {
  int batteryCapacity; // Battery capacity in kWh

  // Constructor passing brand and speed to super, and setting batteryCapacity
  ElectricCar(String brand, int speed, this.batteryCapacity)
      : super(brand, speed);

  // Method overriding using @override
  @override
  void displayInfo() {
    print('ElectricCar Brand: $brand, Speed: ${speed} km/h, Battery: ${batteryCapacity} kWh');
  }
}

// -----------------------------------------------------------------------------
// EXERCISE 3: FUNCTION DEFINITIONS (NORMAL & ARROW SYNTAX)
// -----------------------------------------------------------------------------

/// 4a. Normal function syntax: calculates area of a rectangle
double calculateArea(double width, double height) {
  return width * height;
}

/// 4b. Arrow function syntax (=>): squares an integer value
int square(int number) => number * number;

// -----------------------------------------------------------------------------
// EXERCISE 5: ASYNC & FUTURE FUNCTIONS
// -----------------------------------------------------------------------------

/// 1 & 2. Async function using Future, await, and Future.delayed to simulate loading data
Future<String> fetchUserData() async {
  print('  [Async] Fetching user data from server...');
  // Simulate 1.5 seconds delay
  await Future.delayed(Duration(milliseconds: 1500));
  return 'User Data Loaded Successfully!';
}

/// 4. Generator function to create a simple Stream of integers
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    yield i;
  }
}

// -----------------------------------------------------------------------------
// MAIN FUNCTION & EXERCISE RUNNERS
// -----------------------------------------------------------------------------

Future<void> main() async {
  print('====================================================');
  print('         LAB 2 - DART ESSENTIALS PRACTICE           ');
  print('====================================================\n');

  // Run Exercise 1
  runExercise1();

  // Run Exercise 2
  runExercise2();

  // Run Exercise 3
  runExercise3();

  // Run Exercise 4
  runExercise4();

  // Run Exercise 5
  await runExercise5();

  print('\n====================================================');
  print('         ALL EXERCISES COMPLETED SUCCESSFULLY       ');
  print('====================================================');
}

/// ----------------------------------------------------------------------------
/// Exercise 1 – Basic Syntax & Data Types
/// ----------------------------------------------------------------------------
void runExercise1() {
  print('--- EXERCISE 1: BASIC SYNTAX & DATA TYPES ---');

  // Step 2: Declare variables using int, double, String, bool
  int age = 22;
  double height = 1.75;
  String name = 'Nguyen Van A';
  bool isStudent = true;

  // Step 3: Use print() and string interpolation ($var, ${expr}) to show values
  print('Student Name (\$var): $name');
  print('Age (\$var): $age');
  print('Height (\$var): $height m');
  print('Is Student (\$var): $isStudent');

  // Demonstrating expression string interpolation ${expr}
  print('Next year age (\${age + 1}): ${age + 1}');
  print('Height in centimeters (\${height * 100}): ${height * 100} cm');
  print('Status summary (\${expr}): ${isStudent ? "$name is currently enrolled" : "$name is not a student"}\n');
}

/// ----------------------------------------------------------------------------
/// Exercise 2 – Collections & Operators
/// ----------------------------------------------------------------------------
void runExercise2() {
  print('--- EXERCISE 2: COLLECTIONS & OPERATORS ---');

  // Step 1: Create a List of integers
  List<int> numbers = [10, 20, 30, 40];
  print('Initial List: $numbers');

  // Step 4a: Indexing, add(), remove() on List
  print('Accessing index 1 (numbers[1]): ${numbers[1]}');
  numbers.add(50); // add item
  print('After add(50): $numbers');
  numbers.remove(20); // remove item by value
  print('After remove(20): $numbers');

  // Step 2: Use arithmetic & comparison operators (+, -, ==, &&, ? :)
  int a = 15;
  int b = 5;
  int sum = a + b; // Arithmetic +
  int diff = a - b; // Arithmetic -
  bool isEqual = (a == b); // Comparison ==
  bool checkBoth = (a > 10) && (b < 10); // Logical &&
  String resultStr = (sum > 10) ? 'Sum is greater than 10' : 'Sum is 10 or less'; // Ternary ? :

  print('Arithmetic + ($a + $b): $sum');
  print('Arithmetic - ($a - $b): $diff');
  print('Comparison == ($a == $b): $isEqual');
  print('Logical && ($a > 10 && $b < 10): $checkBoth');
  print('Ternary operator (? :): $resultStr');

  // Step 3: Create a Set (unique values) and a Map (key-value)
  Set<String> uniqueTags = {'Dart', 'Flutter', 'Mobile'};
  print('\nInitial Set (unique values): $uniqueTags');
  uniqueTags.add('Dart'); // Duplicate won't be added
  uniqueTags.add('OOP');
  print('After add("Dart") & add("OOP"): $uniqueTags');
  uniqueTags.remove('Mobile');
  print('After remove("Mobile"): $uniqueTags');

  // Map (key-value)
  Map<String, dynamic> studentInfo = {
    'id': 'SE12345',
    'name': 'Alice',
    'score': 8.5
  };
  print('\nInitial Map: $studentInfo');

  // Step 4b: Map access, adding new key-value, removing key
  print('Map Access (studentInfo["name"]): ${studentInfo['name']}');
  studentInfo['course'] = 'Mobile Development'; // Add key-value
  print('After adding key "course": $studentInfo');
  studentInfo.remove('score'); // Remove key
  print('After removing key "score": $studentInfo\n');
}

/// ----------------------------------------------------------------------------
/// Exercise 3 – Control Flow & Functions
/// ----------------------------------------------------------------------------
void runExercise3() {
  print('--- EXERCISE 3: CONTROL FLOW & FUNCTIONS ---');

  // Step 1: Write an if/else block to check score
  double score = 88.5;
  String grade;

  if (score >= 90) {
    grade = 'A (Excellent)';
  } else if (score >= 80) {
    grade = 'B (Very Good)';
  } else if (score >= 70) {
    grade = 'C (Good)';
  } else if (score >= 50) {
    grade = 'D (Passed)';
  } else {
    grade = 'F (Failed)';
  }
  print('If/Else Score check: Score = $score -> Grade = $grade');

  // Step 2: Write a switch case for day of week
  int dayOfWeek = 3; // 1: Mon, 2: Tue, 3: Wed, etc.
  String dayName;

  switch (dayOfWeek) {
    case 1:
      dayName = 'Monday';
      break;
    case 2:
      dayName = 'Tuesday';
      break;
    case 3:
      dayName = 'Wednesday';
      break;
    case 4:
      dayName = 'Thursday';
      break;
    case 5:
      dayName = 'Friday';
      break;
    case 6:
      dayName = 'Saturday';
      break;
    case 7:
      dayName = 'Sunday';
      break;
    default:
      dayName = 'Invalid Day';
  }
  print('Switch Case Day Check: Day $dayOfWeek -> $dayName');

  // Step 3: Loop through a collection using for, for-in, and forEach()
  List<String> fruits = ['Apple', 'Banana', 'Cherry'];
  print('\n--- Loops Demonstration ---');

  // Standard for loop
  print('1. Standard for loop:');
  for (int i = 0; i < fruits.length; i++) {
    print('   fruits[$i] = ${fruits[i]}');
  }

  // For-in loop
  print('2. For-in loop:');
  for (var fruit in fruits) {
    print('   Fruit item: $fruit');
  }

  // forEach() loop with arrow syntax
  print('3. forEach() loop:');
  fruits.forEach((fruit) => print('   forEach item: $fruit'));

  // Step 4: Call functions (normal and arrow syntax)
  print('\n--- Functions Demonstration ---');
  double rectArea = calculateArea(4.5, 10.0);
  print('Normal Function (calculateArea(4.5, 10.0)): $rectArea');

  int squareVal = square(7);
  print('Arrow Function (square(7)): $squareVal\n');
}

/// ----------------------------------------------------------------------------
/// Exercise 4 – Intro to OOP
/// ----------------------------------------------------------------------------
void runExercise4() {
  print('--- EXERCISE 4: INTRO TO OOP ---');

  // Step 4: Instantiate objects and print results

  // 1. Using standard constructor for Car
  Car standardCar = Car('Toyota', 120);
  print('1. Standard Car Instance:');
  standardCar.displayInfo();

  // 2. Using named constructor Car.withBrand
  Car namedCar = Car.withBrand('Honda');
  print('2. Named Constructor Car Instance:');
  namedCar.displayInfo();

  // 3. Using subclass ElectricCar overriding displayInfo
  ElectricCar myTesla = ElectricCar('Tesla Model 3', 150, 75);
  print('3. Subclass ElectricCar Instance (Overridden method):');
  myTesla.displayInfo();
  print('');
}

/// ----------------------------------------------------------------------------
/// Exercise 5 – Async, Future, Null Safety & Streams
/// ----------------------------------------------------------------------------
Future<void> runExercise5() async {
  print('--- EXERCISE 5: ASYNC, FUTURE, NULL SAFETY & STREAMS ---');

  // Step 1 & 2: Async function using Future + await and Future.delayed()
  print('1 & 2. Future + await (Future.delayed simulation):');
  String asyncResult = await fetchUserData();
  print('  Async Output: $asyncResult');

  // Step 3: Practice null-safety operators (?, ??, !)
  print('\n3. Null Safety Operators (?, ??, !):');

  // Nullable variable declaration with ?
  String? nullableName;
  print('  Nullable variable (String? nullableName): $nullableName');

  // Safe navigation operator ?
  int? nameLength = nullableName?.length;
  print('  Safe navigation (nullableName?.length): $nameLength');

  // Null-coalescing operator ?? (provides default value if null)
  String displayName = nullableName ?? 'Guest User';
  print('  Null-coalescing (nullableName ?? "Guest User"): $displayName');

  // Assign a non-null value and test assertion operator !
  nullableName = 'John Doe';
  print('  Assigned value: $nullableName');

  // Null assertion operator ! (asserts value is not null)
  String mandatoryName = nullableName!;
  print('  Null assertion (nullableName!): $mandatoryName');

  // Step 4: Create a simple Stream of integers and listen to values
  print('\n4. Stream of integers listening to values:');
  print('  Starting stream emission...');

  // Listening to stream using await for loop
  await for (int val in countStream(3)) {
    print('  Stream emitted value: $val');
  }

  print('  Stream finished emission.\n');
}
