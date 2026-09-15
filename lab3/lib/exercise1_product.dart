import 'dart:async';

/// Exercise 1 – Product Model & Repository
/// Goal: Understand Futures (asynchronous single values) and Streams (asynchronous data streams).

// 1. Define Product class containing id, name, price
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

// 2. Implement ProductRepository
class ProductRepository {
  // Initial in-memory product list
  final List<Product> _products = [
    Product(id: 'P01', name: 'Laptop Pro', price: 1299.99),
    Product(id: 'P02', name: 'Wireless Mouse', price: 29.99),
    Product(id: 'P03', name: 'Mechanical Keyboard', price: 89.99),
  ];

  // 3. Use StreamController.broadcast() to allow multiple listeners to listen to real-time additions
  final StreamController<Product> _liveAddedController = StreamController<Product>.broadcast();

  /// Returns a Future containing all initial products after a simulated network delay.
  Future<List<Product>> getAll() async {
    // Simulate network latency (500ms delay)
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_products);
  }

  /// Exposes a broadcast Stream emitting newly added Product items in real-time.
  Stream<Product> get liveAdded => _liveAddedController.stream;

  /// Adds a new product to repository and notifies stream subscribers.
  void addProduct(Product product) {
    _products.add(product);
    // Emit new product to live stream
    _liveAddedController.add(product);
  }

  /// Closes the StreamController when repository is disposed
  void dispose() {
    _liveAddedController.close();
  }
}

/// Helper function to execute Exercise 1 demonstration
Future<void> runExercise1() async {
  print('==================================================');
  print('--- Exercise 1: Product Model & Repository ---');
  print('==================================================');

  final repository = ProductRepository();

  // 1. Subscribe to real-time liveAdded stream
  final subscription = repository.liveAdded.listen((product) {
    print('[STREAM EVENT] Live product added: $product');
  });

  // 2. Fetch initial product list using Future
  print('Fetching all existing products asynchronously...');
  final initialProducts = await repository.getAll();
  print('Fetched ${initialProducts.length} products:');
  for (final p in initialProducts) {
    print('  - $p');
  }

  // 3. Add new products to trigger broadcast stream updates
  print('\nAdding new products to trigger live broadcast stream events...');
  await Future.delayed(const Duration(milliseconds: 300));
  repository.addProduct(Product(id: 'P04', name: '4K Monitor', price: 349.50));

  await Future.delayed(const Duration(milliseconds: 300));
  repository.addProduct(Product(id: 'P05', name: 'USB-C Dock', price: 75.00));

  // Small delay before cleanup to let stream finish emitting
  await Future.delayed(const Duration(milliseconds: 200));
  await subscription.cancel();
  repository.dispose();
  print('Exercise 1 Completed.\n');
}
