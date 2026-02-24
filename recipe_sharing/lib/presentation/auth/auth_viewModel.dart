import 'package:flutter/material.dart';
import 'package:recipe_sharing/data/helpers/password_checker.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/models/auth_result.dart';
import 'package:recipe_sharing/presentation/auth/auth_page_state.dart';

import '../../domain/models/validation_info.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepo;
  final PasswordChecker checker = PasswordChecker();

  String _login = '';
  String _email = '';
  String _password = '';
  bool _showPassword = false;
  String _repeatPassword = '';
  ValidationInfo _passwordValidation = ValidationInfo(isValid: false);
  bool _passwordsMatch = true;
  bool _emailOk = false;
  String? _infoMessage;
  AuthResult<Map<String, String>> _result = AuthResultLoading();

  AuthViewModel({required AuthRepository authRepo}) : _authRepo = authRepo;

  void refresh({
    String? login,
    String? email,
    String? password,
    bool? showPassword,
    String? repeatPassword,
    String? infoMessage,
  }) {
    _login = login ?? _login;

    _password = password ?? _password;
    _passwordValidation = password != null
        ? checker.checkPassword(password)
        : _passwordValidation;

    _repeatPassword = repeatPassword ?? _repeatPassword;
    _passwordsMatch = password != null || repeatPassword != null
        ? _password == _repeatPassword
        : _passwordsMatch;

    _showPassword = showPassword ?? _showPassword;

    _email = email ?? _email;
    var regex = RegExp(
      r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$",
      caseSensitive: false,
    );
    _emailOk = email != null ? regex.hasMatch(email) : _emailOk;

    _infoMessage = infoMessage;
  }

  AuthPageState build() => AuthPageState(
    login: _login,
    email: _email,
    emailOk: _emailOk,
    infoMessage: _infoMessage,
    password: _password,
    passwordValidation: _passwordValidation,
    passwordsMatch: _passwordsMatch,
    repeatPassword: _repeatPassword,
    showPassword: _showPassword,
    result: _result,
  );

  void clearResult() {
    _result = AuthResultUnauthorized();
  }

  void startLoading() {
    _result = AuthResultLoading();
  }

  Future<void> confirmLogin() async {
    if (_login.isEmpty || _password.isEmpty) {
      _infoMessage = "Cannot log in with empty fields";
      return;
    }

    _result = await _authRepo.logIn(login: _login, password: _password);
    if (_result is AuthResultAuthorized) {
      SharedPreferencesService.saveUser(
        _result.data!['userId']!,
        _result.data!["userEmail"]!,
        _result.data!["nickname"]!,
      );
    }
  }

  Future<void> confirmRegister() async {
    if (_login.isEmpty ||
        !_passwordValidation.isValid ||
        !_passwordsMatch ||
        !_emailOk) {
      _infoMessage = "Cannot register check fields error";
      return;
    }

    _result = await _authRepo.register(
      login: _login,
      email: _email,
      password: _password,
    );

    if (_result is AuthResultAuthorized) {
      SharedPreferencesService.saveUser(
        _result.data!['userId']!,
        _result.data!["userEmail"]!,
        _result.data!["nickname"]!,
      );
    }
    _infoMessage = _result.info;
  }

  Future<void> authorize() async {
    _result = await _authRepo.authorize();
  }
}
