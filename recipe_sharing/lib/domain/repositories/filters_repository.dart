import 'package:recipe_sharing/domain/models/api_result.dart';

abstract class FiltersRepository {
  Future<APIResult<List<String>>> getCategories();

  Future<APIResult<List<String>>> getFiltersByCategory({
    required String category,
  });

  Future<APIResult<Map<String, List<String>>>> getCategorizedFilters();

  Future<APIResult> attachFiltersToRecipe({
    required String recipeID,
    required List<String> filters,
  });

  Future<APIResult> removeFiltersFromRecipe({
    required String recipeID,
    required List<String> filters,
  });

  Future<APIResult> clearRecipeFilters({
    required String recipeID,
  });
}