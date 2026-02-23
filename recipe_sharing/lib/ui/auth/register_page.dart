import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/domain/models/auth_result.dart';
import 'package:recipe_sharing/presentation/auth/auth_cubit.dart';
import 'package:recipe_sharing/presentation/auth/auth_page_state.dart';
import 'package:recipe_sharing/ui/auth/login_page.dart';
import 'package:recipe_sharing/ui/stadard/error_info_page.dart';

import '../../presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import '../recipes/recipes_screen/recipes_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..authorize(),
      child: BlocBuilder<AuthCubit, AuthPageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Create Account', // More descriptive title
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                ),
              ),
            ),
            body: _buildBody(
              context,
              state,
              () {
                context.read<AuthCubit>().clearResult();
              },
              (value) {
                context.read<AuthCubit>().updateState(login: value);
              },
              (value) {
                context.read<AuthCubit>().updateState(email: value);
              },
              (value) {
                context.read<AuthCubit>().updateState(password: value);
              },
              (value) {
                context.read<AuthCubit>().updateState(repeatPassword: value);
              },
              () {
                context.read<AuthCubit>().confirmRegister();
              },
              () {
                context.read<AuthCubit>().updateState(
                  showPassword: !state.showPassword,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AuthPageState state,
    VoidCallback onReloadPage,
    Function(String) onLoginChanged,
    Function(String) onEmailChanged,
    Function(String) onPasswordChanged,
    Function(String) onRepeatPasswordChanged,
    VoidCallback onConfirmRegister,
    VoidCallback onShowPassword,
  ) {
    final result = state.result;

    if (result is AuthResultAuthorized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipesScreen(loadedDataType: RecipesLoadedDataTypeAll()),
          ),
        );
      });
      return const SizedBox.shrink();
    } else if (result is AuthResultError) {
      return ErrorInfoPage(
        errorInfo: result.info ?? 'Registration failed',
        onReloadPage: () => {onReloadPage()},
      );
    } else if (result is AuthResultLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 8));
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Login',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: state.login.isEmpty ? 'Field cannot be empty' : null,
              ),
              onChanged: (value) => {onLoginChanged(value)},
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: !state.emailOk
                    ? 'Incorrect format of the email'
                    : null,
              ),
              onChanged: (value) => {onEmailChanged(value)},
            ),

            const SizedBox(height: 16),
            TextField(
              obscureText: !state.showPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.showPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => {onShowPassword()},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: !state.passwordValidation.isValid
                    ? state.passwordValidation.error
                    : null,
              ),
              onChanged: (value) => {onPasswordChanged(value)},
            ),
            TextField(
              obscureText: !state.showPassword,
              decoration: InputDecoration(
                labelText: 'Repeat Password',
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.showPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () => {onShowPassword()},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: !state.passwordsMatch
                    ? "Passwords should match"
                    : null,
              ),
              onChanged: (value) => {onRepeatPasswordChanged(value)},
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {onConfirmRegister()},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Create an account',
                ), // Replace with string resource
              ),
            ),

            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      'Already have an account?', // Replace with string resource
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
