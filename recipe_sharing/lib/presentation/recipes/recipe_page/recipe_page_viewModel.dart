import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:quiver/iterables.dart' show range;
import 'package:recipe_sharing/domain/repositories/filters_repository.dart';
import 'package:recipe_sharing/domain/repositories/recipe_repository.dart';
import 'package:recipe_sharing/presentation/recipes/recipe_page/recipe_page_state.dart';
import 'package:recipe_sharing/presentation/recipes/recipe_page/recipe_tabs.dart';

import '../../../domain/models/api_result.dart';
import '../../../domain/models/recipes/ingredient.dart';
import '../../../domain/models/recipes/recipe.dart';
import '../../../domain/models/recipes/step.dart';
import '../../../domain/models/reviews/review_model.dart';

class RecipePageViewmodel extends ChangeNotifier {
  final RecipesRepository _recipes;
  final FiltersRepository _filters;

  APIResult<Recipe> _recipe = APIResultLoading();
  String _loadedRecipeId = '';
  String? _imageUrl;
  String _recipeName = '';
  String _recipeDescription = '';
  double _recipeRating = 0.0;
  int _recipeReviewsCount = 0;
  bool _own = false;
  bool _isFavorite = false;
  List<Ingredient> _ingredients = List.empty(growable: true);
  List<Step> _steps = List.empty(growable: true);
  List<String> _selectedFilters = List.empty(growable: true);
  APIResult<Map<String, List<String>>> _loadedFilters = APIResultLoading();
  APIResult<List<ReviewModel>> _reviews = APIResultLoading();
  bool _isEditingRecord = false;
  bool _openAddIngredientDialog = false;
  bool _openFiltersPage = false;
  bool _openAddStepDialog = false;
  bool _openConfirmDeleteDialog = false;
  Step? _selectedStep;
  int _selectedStepIndex = -1;
  Ingredient? _selectedIngredient;
  int _selectedIngrIndex = -1;
  String? _infoMessage;
  int _selectedRecipeTabIndex = 0;
  bool _isError = false;

  RecipePageViewmodel({
    required RecipesRepository recipes,
    required FiltersRepository filters,
  }) : _recipes = recipes,
       _filters = filters;

  RecipePageState build() {
    return RecipePageState(
      selectedRecipeId: _loadedRecipeId,
      recipe: _recipe,
      imageUrl: _imageUrl,
      recipeName: _recipeName,
      recipeDescription: _recipeDescription,
      recipeRating: _recipeRating,
      recipeReviewsCount: _recipeReviewsCount,
      own: _own,
      isFavorite: _isFavorite,
      ingredients: _ingredients,
      steps: _steps,
      filters: _selectedFilters,
      loadedFilters: _loadedFilters,
      reviews: _reviews,
      isEditingRecord: _isEditingRecord,
      openAddIngredientDialog: _openAddIngredientDialog,
      openFiltersPage: _openFiltersPage,
      openAddStepDialog: _openAddStepDialog,
      openConfirmDeleteDialog: _openConfirmDeleteDialog,
      selectedStep: _selectedStep,
      selectedStepIndex: _selectedStepIndex,
      selectedIngredient: _selectedIngredient,
      selectedIngrIndex: _selectedIngrIndex,
      infoMessage: _infoMessage,
      selectedRecipeTabIndex: _selectedRecipeTabIndex,
      isError: _isError,
    );
  }

  void addIngredient(Ingredient ingredient) {
    if (_ingredients.any((e) => e.name == ingredient.name)) {
      _infoMessage = "Already exists";
      return;
    }

    _ingredients.add(ingredient);
  }

  void startLoadingRecipe() {
    _recipe = APIResultLoading();
  }

  void setFilters(List<String> filters) {
    _selectedFilters = filters;
  }

  void addFilter(String filter) {
    _selectedFilters.add(filter);
    ;
  }

  void removeFilter(String filter) {
    _selectedFilters.remove(filter);
  }

  void startLoadingFilters() {
    _loadedFilters = APIResultLoading();
  }

  Future<void> loadAvailableFilters() async {
    _loadedFilters = await _filters.getCategorizedFilters();
  }

  void addStep(Step newStep) {
    _steps.add(newStep);
  }

  void removeIngredient(Ingredient ingredient) {
    _ingredients.remove(ingredient);
  }

  void removeStep(Step step) {
    _steps.remove(step);
  }

  Future<void> deleteRecipe(VoidCallback afterDeleted) async {
    if (_recipe.data == null || _recipe.data!.recipeID.isEmpty) {
      _infoMessage = "Recipe was not created";
      return;
    }

    var result = await _recipes.deleteRecipe(receiptID: _recipe.data!.recipeID);
    switch (result) {
      case APIResultSucceed():
        afterDeleted();
        break;
      case APIResultLoading():
        break;
      case APIResultError():
        _infoMessage = "Cannot delete recipe: ${result.info}";
        break;
    }
  }

  void setRecipeDescription(String recipeDescription) {
    _recipeDescription = recipeDescription;
  }

  void setRecipeName(String recipeName) {
    _recipeName = recipeName;
  }

  void updateIngredient(int index, Ingredient ingredient) {
    if (_ingredients.indexed.any(
      (e) => e.$1 != index && e.$2.name == ingredient.name,
    )) {
      _infoMessage = "Already exists";
      return;
    }

    _ingredients.replaceRange(index, min(index + 1, _ingredients.length), [
      ingredient,
    ]);
  }

  void updateStep(int index, Step step) {
    _steps.replaceRange(index, min(index + 1, _ingredients.length), [step]);
  }

  Future<void> changeIsFavorite() async {
    if (_recipe.data == null || _recipe.data!.recipeID.isEmpty) {
      _infoMessage = "Recipe not foud";
      return;
    }

    var result = _isFavorite
        ? await _recipes.removeFromFavorites(recipeID: _recipe.data!.recipeID)
        : await _recipes.addToFavorites(recipeID: _recipe.data!.recipeID);

    switch (result) {
      case APIResultSucceed<dynamic>():
        _isFavorite = !_isFavorite;
        break;
      case APIResultLoading<dynamic>():
        break;
      case APIResultError<dynamic>():
        _infoMessage = "Could not change is favorite marker: ${result.info}";
        break;
    }
  }

  void initializeRecipe() {
    _recipe = APIResultSucceed(
      data: Recipe(
        recipeID: '',
        creatorID: '',
        recipeName: '',
        ingredients: [],
        steps: [],
        filters: [],
        timeMinutes: 0.0,
        currentRating: 0.0,
        reviewsCount: 0,
        viewsCount: 0,
        datePublished: Timestamp.now(),
      ),
    );

    _recipeName = '';
    _loadedRecipeId = '';
    _recipeDescription = '';
    _ingredients = [];
    _steps = [];
    _selectedFilters = [];
  }

  void setRecipeTabIndex(int index) {
    _selectedRecipeTabIndex =
        !range(0, RecipeTabs.values.length - 1).contains(index) ? 0 : index;
  }

  void setIsEditingRecord(bool isEditing) {
    _isEditingRecord = _own && isEditing;
  }

  void discardChanges() {
    if (_recipe.data != null) {
      _recipeName = _recipe.data!.recipeName;
      _recipeDescription = _recipe.data!.description ?? '';
      _recipeRating = _recipe.data!.currentRating;
      _recipeReviewsCount = _recipe.data!.reviewsCount;
      _ingredients = _recipe.data!.ingredients;
      _steps = _recipe.data!.steps;
      _isEditingRecord = false;
      _openAddIngredientDialog = false;
      _openFiltersPage = false;
      _openAddStepDialog = false;
      _openConfirmDeleteDialog = false;
      _selectedStep = null;
      _selectedStepIndex = -1;
      _selectedIngredient = null;
      _selectedIngrIndex = -1;
      _infoMessage = null;
      _selectedRecipeTabIndex = 0;
      _isError = false;
    }
  }

  void setOpenIngredientConfigDialog(bool open) {
    _openAddIngredientDialog = open;
  }

  void setOpenStepConfigureDialog(bool open) {
    _openAddStepDialog = open;
  }

  void setOpenFiltersPage(bool open) {
    _openFiltersPage = open;
  }

  void setSelectedIngredient(Ingredient? ingredient) {
    _selectedIngrIndex = ingredient != null
        ? _ingredients.indexOf(ingredient)
        : -1;
    _selectedIngredient = ingredient;
  }

  void setSelectedStep(Step? step) {
    _selectedStepIndex = step != null ? _steps.indexOf(step) : -1;
    _selectedStep = step;
  }

  void setOpenConfirmDeleteDialog(bool open) {
    _openConfirmDeleteDialog = true;
  }

  Future<void> loadRecipe(String recipeId) async {
    _recipe = await _recipes.getRecipeByID(receiptID: recipeId);

    if (_recipe is APIResultSucceed) {
      _loadedRecipeId = _recipe.data!.recipeID;
      _selectedFilters = _recipe.data!.filters;
      _own = _recipe.data!.own;
      _isFavorite =
          (await _recipes.isRecipeInFavorites(receiptID: recipeId)).data ??
          false;

      _recipeName = _recipe.data!.recipeName;
      _recipeDescription = _recipe.data!.description ?? '';
      _recipeRating = _recipe.data!.currentRating;
      _recipeReviewsCount = _recipe.data!.reviewsCount;
      _ingredients = _recipe.data!.ingredients;
      _steps = _recipe.data!.steps;
      _isEditingRecord = false;
      _openAddIngredientDialog = false;
      _openFiltersPage = false;
      _openAddStepDialog = false;
      _openConfirmDeleteDialog = false;
      _selectedStep = null;
      _selectedStepIndex = -1;
      _selectedIngredient = null;
      _selectedIngrIndex = -1;
      _infoMessage = null;
      _selectedRecipeTabIndex = 0;
      _isError = false;
    }
  }

  Future<void> saveChanges() async {
    if (_ingredients.isEmpty || _steps.isEmpty || _recipeName.isEmpty) {
      _infoMessage = "Error! Cannot leave empty name, steps or ingredients.";
      return;
    }
    if (_recipe.data == null) {
      _infoMessage = "Cannot find info about recipe";
      return;
    }

    var editedRecipe = _recipe.data!;
    editedRecipe.ingredients = _ingredients;
    editedRecipe.steps = _steps;
    editedRecipe.recipeName = _recipeName;
    editedRecipe.description = _recipeDescription;
    editedRecipe.filters = _selectedFilters;

    if (editedRecipe.recipeID.isEmpty) {
      var newId = await _recipes.postRecipe(request: editedRecipe);
      switch (newId) {
        case APIResultSucceed<String>():
          editedRecipe.recipeID = newId.data!;
          _recipe = APIResultSucceed(data: editedRecipe);
          _loadedRecipeId = newId.data!;
          break;
        case APIResultLoading<String>():
          _recipe = APIResultLoading();
          break;
        case APIResultError<String>():
          _recipe = APIResultError(info: newId.info);
          break;
      }
    } else {
      var result = await _recipes.updateRecipe(request: editedRecipe);
      switch (result) {
        case APIResultSucceed():
          _recipe = APIResultSucceed(data: editedRecipe);
          break;
        case APIResultLoading():
          _recipe = APIResultLoading();
          break;
        case APIResultError():
          _recipe = APIResultError(info: result.info);
          break;
      }
    }
  }
}
