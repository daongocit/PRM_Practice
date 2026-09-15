import '../lib/exercise1_product.dart';
import '../lib/exercise2_user_json.dart';
import '../lib/exercise3_microtask.dart';
import '../lib/exercise4_stream_transform.dart';
import '../lib/exercise5_factory_cache.dart';

/// Main entry point for Lab 3 – Advanced Dart Practice Exercises.
/// Runs all 5 mini-projects in sequence.
Future<void> main() async {
  print('******************************************************************');
  print('            LAB 3: ADVANCED DART PRACTICE EXERCISES              ');
  print('******************************************************************\n');

  // Exercise 1: Product Model & Repository (Futures and Streams)
  await runExercise1();

  // Exercise 2: User Repository with JSON (Serialization / Deserialization)
  await runExercise2();

  // Exercise 3: Async + Microtask Debugging (Event Loop prioritization)
  await runExercise3();

  // Exercise 4: Stream Transformation (map and where operators)
  await runExercise4();

  // Exercise 5: Factory Constructors & Cache (Singleton pattern)
  runExercise5();

  print('******************************************************************');
  print('        ALL 5 LAB 3 EXERCISES COMPLETED SUCCESSFULLY!            ');
  print('******************************************************************');
}
