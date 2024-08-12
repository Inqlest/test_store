import 'package:test_store/res/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:test_store/router/app_router.dart';

class TestStoreApp extends StatefulWidget {
  const TestStoreApp({super.key});

  @override
  State<TestStoreApp> createState() => _TestStoreAppState();
}

class _TestStoreAppState extends State<TestStoreApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'TestStore',
        themeAnimationDuration: Duration.zero,
        theme: mainTheme);
  }
}
