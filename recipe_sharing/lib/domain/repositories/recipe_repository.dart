import 'dart:io';

import 'package:recipe_sharing/domain/models/filters/filter_model.dart';
import 'package:recipe_sharing/domain/models/filters/recipe_ordering.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';

import '../models/api_result.dart';
import '../models/paged_result.dart';
import '../models/recipes/recipe.dart';

abstract class RecipesRepository {
  Future<APIResult<String>> uploadRecipeImage({
    required File imageFile,
  });

  Future<APIResult<PagedResult<Recipe>>> getFilteredRecipes({
    String? name,
    FiltersModel? filtering,
    RecipeOrdering? ordering,
    bool ascending = true,
    required int page,
    required int pageSize,
    required RecipesLoadedDataType loadedType
  });

  Future<APIResult<Recipe>> getRecipeByID({
    required String receiptID,
  });

  Future<APIResult<bool>> isRecipeInFavorites({
    required String receiptID,
  });

  Future<APIResult<bool>> isRecipeOwn({
    required String receiptID,
  });

  Future<APIResult> addToFavorites({
    required String recipeID,
  });

  Future<APIResult> removeFromFavorites({
    required String recipeID,
  });

  Future<APIResult<String>> postRecipe({
    required Recipe request,
  });

  Future<APIResult> deleteRecipe({
    required String receiptID,
  });

  Future<APIResult> updateRecipe({
    required Recipe request,
  });
}