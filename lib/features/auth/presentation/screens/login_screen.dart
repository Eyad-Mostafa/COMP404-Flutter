import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/validators.dart';
import '../../../leaderboard/presentation/screens/leaderboard_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),

        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessMessage) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));

              // Navigate to Leaderboard after successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
              );
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },

          builder: (context, state) {
            final cubit = context.read<AuthCubit>();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,

                child: ListView(
                  children: [
                    const SizedBox(height: 40),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Login to continue",
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 30),

                    /// Email
                    AppTextField(
                      controller: emailController,
                      label: "Email",
                      validator: Validators.email,
                    ),

                    /// Password
                    AppTextField(
                      controller: passwordController,
                      label: "Password",
                      isPassword: true,
                      validator: Validators.password,
                    ),

                    const SizedBox(height: 30),

                    /// Button
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: const Text("Login"),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
