// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_store/features/profile/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/profile/providers/profile_state.dart';
import 'package:test_store/router/app_router.dart';
import 'package:test_store/shared_pref/shared_prefs.dart';

final prefsService = SharedPreferencesService();

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState());

  Future<void> fetchUserProfile(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await prefsService.getUser();
      if (user != null) {
        _setUser(false, user);
      }
    } catch (e) {
      _setLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile load failed: $e')));
    }
  }

  Future<void> deleteUser(BuildContext context) async {
    prefsService.removeUser();
    AutoRouter.of(context).replace(const AuthorizationRoute());
  }

  Future<void> logout(BuildContext context) async {
    AutoRouter.of(context).replace(const AuthorizationRoute());
  }

  void _setUser(bool value, User user) {
    state = state.copyWith(user: user, isLoading: false);
  }

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}
