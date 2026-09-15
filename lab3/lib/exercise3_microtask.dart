import 'dart:async';

/// Exercise 3 – Async + Microtask Debugging
/// Goal: Differentiate Microtask Queue and Event Queue in Dart's Event Loop.

/// Helper function to execute Exercise 3 demonstration
Future<void> runExercise3() async {
  print('==================================================');
  print('--- Exercise 3: Async + Microtask Debugging ---');
  print('==================================================');

  // Completer used to ensure runExercise3 waits for all async tasks to finish before proceeding
  final completer = Completer<void>();

  print('1. [Synchronous] Start of main execution thread');

  // 1. Queue an item in the Event Queue using Future()
  Future(() {
    print('4. [Event Queue] Callback from Future() executed');
    completer.complete();
  });

  // Another Future with delayed timing queued in Event Queue
  Future.delayed(const Duration(milliseconds: 10), () {
    print('5. [Event Queue] Callback from Future.delayed() executed');
  });

  // 2. Queue an item in the Microtask Queue using scheduleMicrotask()
  scheduleMicrotask(() {
    print('3. [Microtask Queue] Callback from scheduleMicrotask() executed');
  });

  print('2. [Synchronous] End of main execution thread');

  /*
   * 3. EXPLANATION - WHY MICROTASKS RUN BEFORE EVENT CALLBACKS:
   * -----------------------------------------------------------------------
   * Dart's isolate runs a single-threaded Event Loop backed by TWO queues:
   *   1. Microtask Queue: Higher priority tasks (e.g. state changes, internal cleanup).
   *   2. Event Queue: Lower priority external events (e.g. I/O, timers, user taps, Future completion).
   *
   * Execution Rule:
   * - First, synchronous code runs to completion.
   * - Whenever synchronous code pauses/finishes, the Event Loop checks the Microtask Queue.
   * - The Event Loop MUST completely drain/empty all items in the Microtask Queue BEFORE
   *   it processes even a single item from the Event Queue.
   *
   * Execution Order Result:
   *   1. Synchronous Start -> 2. Synchronous End
   *   -> 3. Microtask callback (drains Microtask queue first)
   *   -> 4. Future callback (processes next item in Event queue)
   * -----------------------------------------------------------------------
   */

  print('\n-- Waiting for asynchronous event queue callbacks to finish --');
  await completer.future;
  // Give tiny delay to let Future.delayed finish printing as well
  await Future.delayed(const Duration(milliseconds: 20));
  print('Exercise 3 Completed.\n');
}
