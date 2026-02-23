import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/recipes/ingredient.dart';
import 'package:recipe_sharing/domain/models/recipes/step.dart';
import 'package:recipe_sharing/domain/models/reviews/review_model.dart';

import '../../../domain/models/recipes/recipe.dart';

part 'recipe_page_state.freezed.dart';

@freezed
class RecipePageState with _$RecipePageState {
  const factory RecipePageState({
    @Default(null) String? selectedRecipeId,
    @Default(APIResultLoading()) APIResult<Recipe> recipe,
    @Default(null) String? imageUrl,
    @Default('') String recipeName,
    @Default('') String recipeDescription,
    @Default(0.0) double recipeRating,
    @Default(0) int recipeReviewsCount,
    @Default(false) bool own,
    @Default(false) bool isFavorite,
    @Default([]) List<Ingredient> ingredients,
    @Default([]) List<Step> steps,

    @Default([]) List<String> filters,
    @Default(APIResultLoading())
    APIResult<Map<String, List<String>>> loadedFilters,

    @Default(APIResultLoading()) APIResult<List<ReviewModel>> reviews,
    @Default(false) bool isEditingRecord,
    @Default(false) bool openAddIngredientDialog,
    @Default(false) bool openFiltersPage,
    @Default(false) bool openAddStepDialog,
    @Default(false) bool openConfirmDeleteDialog,
    @Default(null) Step? selectedStep,
    @Default(-1) int selectedStepIndex,
    @Default(null) Ingredient? selectedIngredient,
    @Default(-1) int selectedIngrIndex,
    @Default(null) String? infoMessage,
    @Default(0) int selectedRecipeTabIndex,
    @Default(false) bool isError,
  }) = _RecipePageState;
}
