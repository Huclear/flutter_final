import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/domain/models/auth_result.dart';
import 'package:recipe_sharing/ui/auth/register_page.dart';
import 'package:recipe_sharing/ui/stadard/error_info_page.dart';

import '../../presentation/auth/auth_cubit.dart';
import '../../presentation/auth/auth_page_state.dart';
import '../../presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import '../recipes/recipes_screen/recipes_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..authorize(),
      child: BlocBuilder<AuthCubit, AuthPageState>(
        builder: (blocContext, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(
                blocContext,
              ).colorScheme.surfaceContainerHighest,
              foregroundColor: Theme.of(
                blocContext,
              ).colorScheme.onSurfaceVariant,
              titleTextStyle: Theme.of(blocContext).textTheme.headlineMedium,

              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Login', 
                  style: Theme.of(blocContext).textTheme.headlineMedium,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            body: _buildBody(
              blocContext,
              state,
              () {
                blocContext.read<AuthCubit>().clearResult();
              },
              (login) {
                blocContext.read<AuthCubit>().updateState(email: login);
              },
              (password) {
                blocContext.read<AuthCubit>().updateState(password: password);
              },
              () {
                blocContext.read<AuthCubit>().confirmLogin();
              },
              () {
                blocContext.read<AuthCubit>().updateState(
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
    Function(String) onPasswordChanged,
    VoidCallback onConfirmLogin,
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
        errorInfo:
            result.info ?? 'Unknown error',
        onReloadPage: () => onReloadPage,
      );
    } else if (result is AuthResultLoading) {
      return Center(
        child: SizedBox(
          width: 84,
          height: 84,
          child: CircularProgressIndicator(strokeWidth: 8),
        ),
      );
    } else {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                errorText: state.login.isEmpty ? 'Field cannot be empty' : null,
              ),
              onChanged: (value) => {onLoginChanged(value)},
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

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {onConfirmLogin()},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Login'),
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
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      'Register',
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
