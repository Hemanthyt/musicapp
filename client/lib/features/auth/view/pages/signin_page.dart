import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:client/core/theme/app_pallate.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/core/widgets/snackbar.dart';
import 'package:client/features/auth/model/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(authViewModelProvider.select((val) => val?.isLoading)) ==
            true;

    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInPage(),
              ),
              (_) => false,
            );
          },
          error: (error, st) {
            showSnackBar(
                context, 'Error', error.toString(), ContentType.failure);
          },
          loading: () {});
    });
    return Scaffold(
      appBar: AppBar(),
      // ignore: prefer_const_constructors
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                      suffixIcon: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomField(
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                      suffixIcon: Icon(
                        Icons.lock_person,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      buttonText: 'Sign In',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .loginUser(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                        } else {
                          showSnackBar(context, 'Error', 'Missing Fields!.',
                              ContentType.failure);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: const [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: Pallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
