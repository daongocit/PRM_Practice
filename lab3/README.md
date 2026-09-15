# Lab 3 – Advanced Dart Practice Exercises

This repository contains the complete implementation of **Lab 3: Advanced Dart Practice Exercises**, fully configured and compatible with **Android Studio**, **VS Code**, and **DartPad**.

---

## 📁 Project Structure

```
lab3/
├── pubspec.yaml                 # Package metadata and Dart SDK configuration
├── README.md                    # Project documentation & instructions
├── lab3.dart                    # Standalone single-file version (DartPad compatible)
├── bin/
│   └── lab3.dart                # Modular entry point to run all 5 exercises
└── lib/
    ├── exercise1_product.dart   # Product model & repository with Future & StreamController broadcast
    ├── exercise2_user_json.dart # User model & simulated JSON API deserialization
    ├── exercise3_microtask.dart # Async & Microtask Event Loop execution order demo
    ├── exercise4_stream_transform.dart # Functional stream operations (map & where)
    └── exercise5_factory_cache.dart    # Factory constructor & Singleton caching pattern
```

---

## 🚀 How to Run

### 1. In Android Studio / VS Code
- Open the project directory `e:\PRM\LAB\lab3` in Android Studio or VS Code.
- Ensure the **Dart plugin** is enabled.
- Run `bin/lab3.dart` or `lab3.dart` directly by clicking **Run** or running in terminal:
  ```bash
  dart run bin/lab3.dart
  ```

### 2. In DartPad
- Open [DartPad](https://dartpad.dev).
- Copy the entire contents of [`lab3.dart`](file:///e:/PRM/LAB/lab3/lab3.dart).
- Paste into DartPad and click **Run**.

---

## 📋 Exercise Breakdown & Output Verification

### Exercise 1 – Product Model & Repository
- **Model:** `Product(id, name, price)`
- **Repository:** Uses `Future<List<Product>> getAll()` to fetch existing products asynchronously and `StreamController<Product>.broadcast()` for `liveAdded` real-time product updates.

### Exercise 2 – User Repository with JSON
- **Model:** `User(name, email)` with `User.fromJson(Map<String, dynamic> json)`.
- **API Simulation:** Parses a raw JSON string (`jsonDecode`) into a `Future<List<User>>` and prints results.

### Exercise 3 – Async + Microtask Debugging
- Demonstrates execution order of synchronous code vs `scheduleMicrotask()` vs `Future()`.
- **Key Insight:** Dart's Event Loop drains the **Microtask Queue** completely before executing callbacks from the **Event Queue**.

### Exercise 4 – Stream Transformation
- Creates stream of numbers 1–5 (`Stream.fromIterable([1..5])`).
- Applies `.map((n) => n * n)` to calculate squares.
- Applies `.where((squared) => squared % 2 == 0)` to filter even numbers (`4` and `16`).

### Exercise 5 – Factory Constructors & Cache
- `Settings` class with private constructor `Settings._internal()`.
- Factory constructor `factory Settings()` returns cached singleton instance.
- Verified using `identical(settingsA, settingsB) -> true`.
