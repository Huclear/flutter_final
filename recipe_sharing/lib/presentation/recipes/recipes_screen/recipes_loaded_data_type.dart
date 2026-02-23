import 'package:freezed_annotation/freezed_annotation.dart';

@immutable
sealed class RecipesLoadedDataType {
  const RecipesLoadedDataType();
}

class RecipesLoadedDataTypeOwn extends RecipesLoadedDataType {
  const RecipesLoadedDataTypeOwn();
}

class RecipesLoadedDataTypeCreator extends RecipesLoadedDataType {
  final String creatorId;

  const RecipesLoadedDataTypeCreator({required this.creatorId});
}

class RecipesLoadedDataTypeFavorites extends RecipesLoadedDataType {
  const RecipesLoadedDataTypeFavorites();
}

class RecipesLoadedDataTypeAll extends RecipesLoadedDataType {
  const RecipesLoadedDataTypeAll();
}
