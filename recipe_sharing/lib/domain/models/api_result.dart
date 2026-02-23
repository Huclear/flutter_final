import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
sealed class APIResult<T> {
  final T? data;
  final String? info;

  const APIResult({required this.data, required this.info});
}

class APIResultSucceed<T> extends APIResult<T> {
  const APIResultSucceed({required super.data}) : super(info: null);
}

class APIResultLoading<T> extends APIResult<T> {
  const APIResultLoading() : super(data: null, info: null);
}

class APIResultError<T> extends APIResult<T> {
  const APIResultError({required super.info}) : super(data: null);
}
