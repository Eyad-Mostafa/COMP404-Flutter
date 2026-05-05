import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F1E),

        appBar: AppBar(
            backgroundColor: const Color(0xFF0F0F1E),
            iconTheme: IconThemeData(color: Colors.white),
            title: const Text("Sign Up", style: TextStyle(color: Colors.white),)),

        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessMessage) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) =>  LoginScreen(),
                ),
              );
            }

            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
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
                    const SizedBox(height: 20),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Name
                    AppTextField(
                      controller: nameController,
                      label: "Full Name",
                      validator: Validators.name,
                    ),

                    ///Email
                    AppTextField(
                      controller: emailController,
                      label: "Email",
                      validator: Validators.email,
                    ),

                    ///Password
                    AppTextField(
                      controller: passwordController,
                      label: "Password",
                      isPassword: true,
                      validator: Validators.password,
                    ),

                    ///Confirm Password
                    AppTextField(
                      controller: confirmPasswordController,
                      label: "Confirm Password",
                      isPassword: true,
                      validator: (value) =>
                          Validators.confirmPassword(
                            value,
                            passwordController.text,
                          ),
                    ),

                    const SizedBox(height: 30),

                    ///Button
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            confirmPasswordController.text,
                          );
                        }
                      },
                      child: const Text("Sign Up"),
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