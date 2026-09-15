import 'dart:async';

/// Exercise 4 – Stream Transformation
/// Goal: Use functional stream operators (map and where) to transform and filter data streams.

/// Helper function to execute Exercise 4 demonstration
Future<void> runExercise4() async {
  print('==================================================');
  print('--- Exercise 4: Stream Transformation ---');
  print('==================================================');

  // 1. Create a stream emitting numbers 1 to 5
  final Stream<int> rawNumberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  print('Original input stream numbers: [1, 2, 3, 4, 5]');

  // 2. Transform values to their squares using map()
  // 3. Filter even numbers with where()
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

  // 4. Listen and print each emitted value from the transformed stream
  final completer = Completer<void>();

  processedStream.listen(
    (value) {
      print('>>> [EMITTED VALUE] Output: $value');
    },
    onDone: () {
      print('\nStream finished emitting all items.');
      completer.complete();
    },
    onError: (error) {
      print('Stream error encountered: $error');
      completer.complete();
    },
  );

  await completer.future;
  print('Exercise 4 Completed.\n');
}
