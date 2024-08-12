import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_store/features/registration/providers/registration_notifier.dart';
import 'package:test_store/features/registration/providers/registration_provider.dart';
import 'package:test_store/res/constants/color_constants.dart';
import 'package:test_store/res/constants/font_constants.dart';

@RoutePage()
class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registrationState = ref.watch(registrationProvider);
    final registrationNotifier = ref.read(registrationProvider.notifier);

    final firstNameController = ref.watch(firstNameControllerProvider);
    final secondNameController = ref.watch(secondNameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    final formKey = ref.watch(formKeyProvider);
    final isLoading = registrationState.isLoading;

    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Text('Регистрация', style: titleTextStyle),
                const SizedBox(height: 35),
                isLoading
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            height: 370,
                            child: Center(child: CircularProgressIndicator())))
                    : Column(
                        children: [
                          SizedBox(
                            height: 85,
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                labelText: 'Имя',
                                prefixIcon: Icon(Icons.person,
                                    size: 20, color: kIconColor),
                              ),
                              validator: registrationNotifier.nameValidator,
                            ),
                          ),
                          SizedBox(
                            height: 85,
                            child: TextFormField(
                              controller: secondNameController,
                              decoration: const InputDecoration(
                                labelText: 'Фамилия',
                                prefixIcon: Icon(Icons.person,
                                    size: 20, color: kIconColor),
                              ),
                              validator: registrationNotifier.nameValidator,
                            ),
                          ),
                          SizedBox(
                            height: 85,
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                labelText: 'Электронная почта',
                                prefixIcon: Icon(Icons.email,
                                    size: 20, color: kIconColor),
                              ),
                              validator: registrationNotifier.emailValidator,
                            ),
                          ),
                          SizedBox(
                            height: 85,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _passwordVisible,
                              decoration: InputDecoration(
                                labelText: 'Пароль',
                                prefixIcon: const Icon(Icons.lock,
                                    size: 20, color: kIconColor),
                                suffixIcon: _buildSuffixIcon(),
                              ),
                              validator: registrationNotifier.passwordValidator,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 35),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Зарегистрироваться'),
                      onPressed: () {
                        registrationNotifier.register(context, ref);
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Уже есть аккаунт? ', style: inputFieldTextStyle),
                        GestureDetector(
                          child: Text('Войти',
                              style: inputFieldTextStyle.copyWith(
                                  color: kPrimaryColor)),
                          onTap: () {
                            registrationNotifier
                                .navigateToAuthorization(context);
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
