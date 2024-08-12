import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/profile/providers/profile_notifier.dart';
import 'package:test_store/features/profile/providers/profile_state.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) {
    return ProfileNotifier();
  },
);
