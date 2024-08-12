import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/autorization/providers/auth_notifier.dart';
import 'package:test_store/features/autorization/providers/auth_provider.dart';
import 'package:test_store/res/constants/color_constants.dart';
import 'package:test_store/res/constants/font_constants.dart';

@RoutePage()
class AuthorizationScreen extends ConsumerStatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  ConsumerState<AuthorizationScreen> createState() =>
      _AuthorizationScreenState();
}

class _AuthorizationScreenState extends ConsumerState<AuthorizationScreen> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final autorizationState = ref.watch(authorizationProvider);
    final autorizationNotifier = ref.read(authorizationProvider.notifier);

    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    final isLoading = autorizationState.isLoading;
    final formKey = ref.watch(formKeyProvider);

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 190),
                Text('Вход', style: titleTextStyle),
                const SizedBox(height: 60),
                (isLoading)
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 190,
                            child: Center(child: CircularProgressIndicator())))
                    : Column(
                        children: [
                          SizedBox(
                            height: 85,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Электронная почта',
                                prefixIcon: Icon(Icons.email,
                                    size: 20, color: kIconColor),
                              ),
                              validator: (value) =>
                                  autorizationNotifier.emailValidator(value),
                            ),
                          ),
                          SizedBox(
                            height: 90,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Пароль',
                                prefixIcon: const Icon(Icons.lock,
                                    size: 20, color: kIconColor),
                                suffixIcon: _buildSuffixIcon(),
                              ),
                              validator: (value) =>
                                  autorizationNotifier.passwordValidator(value),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 170),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Войти'),
                      onPressed: () {
                        autorizationNotifier.login(context, ref);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Нет аккаунта? ', style: inputFieldTextStyle),
                        GestureDetector(
                          child: Text('Создать',
                              style: inputFieldTextStyle.copyWith(
                                  color: kPrimaryColor)),
                          onTap: () {
                            autorizationNotifier
                                .navigateToRegistration(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
      icon: Icon(
        _passwordVisible ? Icons.visibility_off : Icons.visibility,
      ),
      style: const ButtonStyle(
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          iconColor: WidgetStatePropertyAll(kIconColor)),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );
  }
}
