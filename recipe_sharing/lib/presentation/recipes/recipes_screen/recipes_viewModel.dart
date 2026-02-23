import 'package:flutter/foundation.dart';
import 'package:recipe_sharing/data/repositories/shared_prefs_storage.dart';
import 'package:recipe_sharing/domain/models/filters/filter_model.dart';
import 'package:recipe_sharing/domain/repositories/filters_repository.dart';
import 'package:recipe_sharing/domain/repositories/recipe_repository.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_screen_state.dart';

import '../../../domain/models/api_result.dart';
import '../../../domain/models/filters/recipe_ordering.dart';
import '../../../domain/models/paged_result.dart';
import '../../../domain/models/recipes/recipe.dart';

class RecipesViewModel extends ChangeNotifier {
  final RecipesRepository _recipes;
  final FiltersRepository _filters;

  RecipesViewModel({
    required RecipesRepository recipes,
    required FiltersRepository filters,
  }) : _recipes = recipes,
       _filters = filters;

  String _currentUserName = '';
  String _currentUserEmail = '';

  APIResult<PagedResult<Recipe>> _loadedRecipes = APIResultLoading();
  APIResult<Map<String, List<String>>> _loadedFilters = APIResultLoading();
  List<String>? _searchedFilters = List.empty(growable: true);
  List<String>? _searchedIngredients = List.empty(growable: true);
  int _timeFrom = 0;
  int _timeTo = 99999;
  RecipeOrdering? _recipeOrdering;
  bool _ascending = true;
  String _searchString = '';
  int _currentPage = 1;
  int _maxPages = 1;
  int _pageSize = 10;
  RecipesLoadedDataType _recipesLoadedDataType = RecipesLoadedDataTypeAll();
  bool _openSearch = false;
  bool _openSelectOrderingMenu = false;
  bool _expandFiltersTab = false;
  bool _openFiltersPage = false;

  RecipesScreenState build() {
    return RecipesScreenState(
      currentUserEmail: _currentUserEmail,
      currentUserName: _currentUserName,

      recipes: _loadedRecipes,
      loadedFilters: _loadedFilters,
      searchedFilters: _searchedFilters,
      searchedIngredients: _searchedIngredients,
      timeFrom: _timeFrom,
      timeTo: _timeTo,
      recipeOrdering: _recipeOrdering,
      ascending: _ascending,
      searchString: _searchString,
      currentPage: _currentPage,
      maxPages: _maxPages,
      pageSize: _pageSize,
      expandFiltersTab: _expandFiltersTab,
      openFiltersPage: _openFiltersPage,
      openSearch: _openSearch,
      openSelectOrderingMenu: _openSelectOrderingMenu,
      recipesLoadedDataType: _recipesLoadedDataType,
    );
  }

  Future<void> loadCurrentUser() async {
    var user = await SharedPreferencesService.getCurrentUser();
    _currentUserEmail = user["userEmail"] ?? 'Unknown @';
    _currentUserName = user["userNickname"] ?? 'Unknown name';
  }

  void startLoading() {
    _loadedRecipes = APIResultLoading();
  }

  void startLoadingFilters() {
    _loadedFilters = APIResultLoading();
  }

  void selectLoadedType(RecipesLoadedDataType loadedType) {
    _recipesLoadedDataType = loadedType;
  }

  Future<void> loadRecipes({required int page, int perPage = 10}) async {
    var filtersModel = FiltersModel(
      tags: _searchedFilters,
      ingredients: _searchedFilters,
      timeFrom: _timeFrom,
      timeTo: _timeTo,
    );

    _loadedRecipes = await _recipes.getFilteredRecipes(
      page: page,
      pageSize: _pageSize,
      loadedType: _recipesLoadedDataType,
      filtering: filtersModel,
      ordering: _recipeOrdering,
      ascending: _ascending,
      name: _searchString,
    );

    if (_loadedRecipes is APIResultSucceed) {
      _currentPage = _loadedRecipes.data!.currentPage;
      _maxPages = _loadedRecipes.data!.totalPages;
      _pageSize = _loadedRecipes.data!.pageSize;
    }
  }

  Future<void> loadAvailableFilters() async {
    _loadedFilters = await _filters.getCategorizedFilters();
  }

  void setSearchedFilters(List<String> filters) {
    _searchedFilters = filters;
  }

  void addSearchedFilter(String filterValue) {
    _searchedFilters == null
        ? _searchedFilters = List.of([filterValue], growable: true)
        : _searchedFilters!.add(filterValue);
  }

  void removeSearchedFilter(String filterValue) {
    if (_searchedFilters != null) {
      _searchedFilters!.remove(filterValue);
    }
  }

  void clearSearchedFilters() {
    if (_searchedFilters != null) {
      _searchedFilters!.clear();
    }
  }

  void addSearchedIngredient(String ingredientName) {
    _searchedIngredients == null
        ? _searchedIngredients = List.of([ingredientName], growable: true)
        : _searchedIngredients!.add(ingredientName);
  }

  void removeSearchedIngredient(String ingredientName) {
    if (_searchedIngredients != null) {
      _searchedIngredients!.remove(ingredientName);
    }
  }

  void clearSearchedIngredient() {
    if (_searchedIngredients != null) {
      _searchedIngredients!.clear();
    }
  }

  void setSearchName(String searchName) {
    _searchString = searchName;
  }

  void setOpenSearchString(bool open) {
    _openSearch = open;
  }

  void setOpenFiltersPage(bool open) {
    _openFiltersPage = open;
  }

  void setOpenFiltersTab(bool open) {
    _expandFiltersTab = open;
  }

  void setOpenOrderingMenu(bool open) {
    _openSelectOrderingMenu = open;
  }

  void setOrdering(RecipeOrdering ordering) {
    _ascending = ordering == _recipeOrdering ? !_ascending : true;
    _recipeOrdering = ordering;
  }

  void setTimeFrom(int timeFrom) {
    _timeFrom = timeFrom;
  }

  void setTimeTo(int timeTo) {
    _timeTo = timeTo;
  }
}
