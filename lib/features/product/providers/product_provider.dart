import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/product/providers/product_notifier.dart';
import 'package:test_store/features/product/providers/product_state.dart';
import 'package:test_store/shared_pref/shared_prefs.dart';

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) {
    final sharedPreferencesService =
        ref.watch(sharedPreferencesServiceProvider);
    return ProductNotifier(sharedPreferencesService);
  },
);

final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>(
  (ref) => SharedPreferencesService(),
);
