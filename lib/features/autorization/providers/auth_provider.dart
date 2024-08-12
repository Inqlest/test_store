import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/autorization/providers/auth_notifier.dart';
import 'package:test_store/features/autorization/providers/auth_state.dart';

final authorizationProvider =
    StateNotifierProvider<AuthorizationNotifier, AuthorizationState>(
  (ref) {
    return AuthorizationNotifier();
  },
);
