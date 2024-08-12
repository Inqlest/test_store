import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/test_store_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TestStoreApp(),
    ),
  );
}
