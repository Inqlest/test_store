// ignore_for_file: use_build_context_synchronously

import 'package:test_store/features/autorization/providers/auth_state.dart';
import 'package:test_store/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/shared_pref/shared_prefs.dart';

final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());
final formKeyProvider = Provider((ref) => GlobalKey<FormState>());
final prefsService = SharedPreferencesService();

class AuthorizationNotifier extends StateNotifier<AuthorizationState> {
  AuthorizationNotifier() : super(AuthorizationState());

  Future<void> login(BuildContext context, WidgetRef ref) async {
    final formKey = ref.read(formKeyProvider);
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);

    if (formKey.currentState?.validate() ?? false) {
      _setLoading(true);
      try {
        await Future.delayed(const Duration(seconds: 1));

        final user = await prefsService.getUser();

        if (emailController.text == user?.email &&
            passwordController.text == user?.password) {
          navigateToProduct(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email or password'),
            ),
          );
        }
        _setLoading(false);
      } catch (e) {
        _setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    }
  }

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void navigateToRegistration(BuildContext context) {
    AutoRouter.of(context).replace(const RegistrationRoute());
  }

  void navigateToProduct(BuildContext context) {
    AutoRouter.of(context).replace(const ProductRoute());
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это поле не может быть пустым';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\\.[a-z]+").hasMatch(value)) {
      return ("Введена некорректрая почта");
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это поле не может быть пустым';
    }
    if (!RegExp(r'^.{4,}$').hasMatch(value)) {
      return ("Пароль должен быть больше 4 символов");
    }
    return null;
  }
}
