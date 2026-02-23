import 'package:recipe_sharing/domain/models/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult<Map<String, String>>> register({
    required String login,
    required String email,
    required String password,
  });

  Future<AuthResult<Map<String, String>>> logIn({
    required String login,
    required String password,
  });

  Future<AuthResult<Map<String, String>>> authorize();
}