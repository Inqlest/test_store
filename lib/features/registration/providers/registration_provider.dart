import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/registration/providers/registration_notifier.dart';
import 'package:test_store/features/registration/providers/registration_state.dart';

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationState>(
  (ref) {
    return RegistrationNotifier();
  },
);
