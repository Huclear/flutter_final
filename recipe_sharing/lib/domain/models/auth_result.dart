import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
sealed class AuthResult<T> {
  final T? data;
  final String? info;

  const AuthResult({required this.data, required this.info});
}

class AuthResultLoading<T> extends AuthResult<T> {
  const AuthResultLoading() : super(data: null, info: '');
}

class AuthResultAuthorized<T> extends AuthResult<T> {
  const AuthResultAuthorized({required super.data}) : super(info: null);
}

class AuthResultUnauthorized<T> extends AuthResult<T> {
  const AuthResultUnauthorized() : super(data: null, info: null);
}

class AuthResultError<T> extends AuthResult<T> {
  const AuthResultError({required super.info}) : super(data: null);
}
