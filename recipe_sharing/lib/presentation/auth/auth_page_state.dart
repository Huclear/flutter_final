import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_sharing/domain/models/auth_result.dart';
import '../../domain/models/validation_info.dart';

part 'auth_page_state.freezed.dart';

@freezed
class AuthPageState with _$AuthPageState {
  const factory AuthPageState({
    @Default('') String login,
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool showPassword,
    @Default('') String repeatPassword,
    @Default(ValidationInfo(isValid: false)) ValidationInfo passwordValidation,
    @Default(false) bool passwordsMatch,
    @Default(false) bool emailOk,
    String? infoMessage,
    @Default(AuthResultLoading()) AuthResult result
  }) = _AuthPageState;
}