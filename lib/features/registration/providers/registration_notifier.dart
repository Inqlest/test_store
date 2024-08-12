// ignore_for_file: use_build_context_synchronously

import 'package:test_store/features/profile/model/user.dart';
import 'package:test_store/features/registration/providers/registration_state.dart';
import 'package:test_store/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/shared_pref/shared_prefs.dart';

final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());
final firstNameControllerProvider = Provider((ref) => TextEditingController());
final secondNameControllerProvider = Provider((ref) => TextEditingController());
final formKeyProvider = Provider((ref) => GlobalKey<FormState>());
final prefsService = SharedPreferencesService();

class RegistrationNotifier extends StateNotifier<RegistrationState> {
  RegistrationNotifier() : super(RegistrationState());

  Future<void> register(BuildContext context, WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 1));

    final formKey = ref.read(formKeyProvider);
    final firstNameController = ref.read(firstNameControllerProvider);
    final secondNameController = ref.read(secondNameControllerProvider);
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);

    if ((formKey.currentState?.validate() ?? false)) {
      _setLoading(true);
      try {
        final user = User(
          firstName: firstNameController.text,
          secondName: secondNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        await prefsService.saveUser(user);
        navigateToAuthorization(context);
        _setLoading(false);
      } catch (e) {
        _setLoading(false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    }
  }

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> navigateToAuthorization(BuildContext context) async {
    await AutoRouter.of(context).replace(const AuthorizationRoute());
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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Это поле не может быть пустым';
    }
    if (!RegExp(r'^\p{L}+$', unicode: true).hasMatch(value)) {
      return ("Имя не может иметь символов");
    }
    return null;
  }
}
