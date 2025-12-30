import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thebites/src/core/widgets/buttons/app_button.dart';

import '../../../core/di/injection.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/inputs/app_text_field.dart';
import '../../../core/widgets/loaders/app_loader.dart';
import '../auth/auth_cubit.dart';
import '../auth/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.bg, AppColors.bg2],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      offset: const Offset(0, 14),
                      color: Colors.black.withOpacity(0.12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Header / Logo
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.08),
                                )
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('TheBites', style: textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(
                            'Login to continue',
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Email
                    AppTextField(
                      label: 'Email',
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 14),

                    /// Password
                    AppTextField(
                      label: 'Password',
                      controller: _passwordCtrl,
                      obscureText: _obscure,
                      suffix: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => setState(() {
                          _obscure = !_obscure;
                        }),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Login Button + State
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error!),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return AppButton(
                          text: state.loading ? 'Signing in...' : 'Login',
                          onPressed: state.loading
                              ? null
                              : () {
                                  context.read<AuthCubit>().signIn(
                                        _emailCtrl.text.trim(),
                                        _passwordCtrl.text,
                                      );
                                },
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    /// Forgot Password
                    TextButton(
                      onPressed: () {
                        final email = _emailCtrl.text.trim();
                        if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enter email to reset password'),
                            ),
                          );
                          return;
                        }
                        context.read<AuthCubit>().sendPasswordReset(email);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reset email sent (if exists)'),
                          ),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),

                    const SizedBox(height: 8),

                    /// Footer note
                    Text(
                      'Secure login using Firebase Authentication',
                      style: textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}