import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/domain/models/paged_result.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import '../../../domain/models/filters/recipe_ordering.dart';
import '../../../domain/models/recipes/recipe.dart';

part 'recipes_screen_state.freezed.dart';

@freezed
class RecipesScreenState with _$RecipesScreenState {
  const factory RecipesScreenState({
    @Default('') String currentUserName,
    @Default('') String currentUserEmail,

    @Default(APIResultLoading()) APIResult<PagedResult<Recipe>> recipes,
    @Default(APIResultLoading())
    APIResult<Map<String, List<String>>> loadedFilters,
    @Default(null) List<String>? searchedFilters,
    @Default(null) List<String>? searchedIngredients,
    @Default(0) int timeFrom,
    @Default(99999) int timeTo,
    @Default(null) RecipeOrdering? recipeOrdering,
    @Default(true) bool ascending,
    @Default('') String searchString,
    @Default(1) int currentPage,
    @Default(1) int maxPages,
    @Default(10) int pageSize,
    @Default(RecipesLoadedDataTypeAll())
    RecipesLoadedDataType recipesLoadedDataType,
    @Default(false) bool openSearch,
    @Default(false) bool openSelectOrderingMenu,
    @Default(false) bool expandFiltersTab,
    @Default(false) bool openFiltersPage,
  }) = _RecipesScreenState;
}
