import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/presentation/recipes/recipe_page/recipe_page_state.dart';
import 'package:recipe_sharing/presentation/recipes/recipe_page/recipe_page_viewModel.dart';

import '../../../data/repositories/firebase_filters_repository.dart';
import '../../../data/repositories/firebase_recipe_repository.dart';
import '../../../domain/models/recipes/ingredient.dart';
import '../../../domain/models/recipes/step.dart';

class RecipePageCubit extends Cubit<RecipePageState> {
  final RecipePageViewmodel _viewModel = RecipePageViewmodel(
    recipes: FirebaseRecipesRepository(),
    filters: FirebaseFiltersRepository(),
  );
  RecipePageCubit() : super(RecipePageState());

  Future<void> saveChanges() async {
    await _viewModel.saveChanges();
    emit(_viewModel.build());
  }

  Future<void> loadRecipe(String? recipeId) async {
    _viewModel.startLoadingRecipe();
    emit(_viewModel.build());
    if (recipeId == null) {
      _viewModel.initializeRecipe();
    } else {
      await _viewModel.loadRecipe(recipeId);
    }
    emit(_viewModel.build());
  }

  void setFilters(List<String> filters) {
    _viewModel.setFilters(filters);
    emit(_viewModel.build());
  }

  void addFilter(String filter) {
    _viewModel.addFilter(filter);
    emit(_viewModel.build());
  }

  void removeFilter(String filter) {
    _viewModel.removeFilter(filter);
    emit(_viewModel.build());
  }

  Future<void> loadFilters() async {
    _viewModel.startLoadingFilters();
    emit(_viewModel.build());
    await _viewModel.loadAvailableFilters();
    emit(_viewModel.build());
  }

  void discardChanges() {
    _viewModel.discardChanges();
    emit(_viewModel.build());
  }

  void setEditRecord(bool edit) {
    _viewModel.setIsEditingRecord(edit);
    emit(_viewModel.build());
  }

  void setOpenConfirmDeleteDialog(bool open) {
    _viewModel.setOpenConfirmDeleteDialog(open);
    emit(_viewModel.build());
  }

  void setOpenFiltersPage(bool open) {
    _viewModel.setOpenFiltersPage(open);
    emit(_viewModel.build());
  }

  Future<void> changeIsFavorite() async {
    await _viewModel.changeIsFavorite();
    emit(_viewModel.build());
  }

  void setOpenIngredientConfigureDialog(bool open) {
    _viewModel.setOpenIngredientConfigDialog(open);
    emit(_viewModel.build());
  }

  void addIngredient(Ingredient ingredient) {
    _viewModel.addIngredient(ingredient);
    emit(_viewModel.build());
  }

  void updateIngredient(int index, Ingredient ingredient) {
    _viewModel.updateIngredient(index, ingredient);
    _viewModel.setSelectedIngredient(null);
    emit(_viewModel.build());
  }

  void removeIngredient(Ingredient ingredient) {
    _viewModel.removeIngredient(ingredient);
    emit(_viewModel.build());
  }

  void setSelectedIngredient(Ingredient ingredient) {
    _viewModel.setSelectedIngredient(ingredient);
    emit(_viewModel.build());
  }

  void setOpenStepConfigureDialog(bool open) {
    _viewModel.setOpenStepConfigureDialog(open);
    emit(_viewModel.build());
  }

  void addStep(Step step) {
    _viewModel.addStep(step);
    emit(_viewModel.build());
  }

  void updateStep(int index, Step step) {
    _viewModel.updateStep(index, step);
    _viewModel.setSelectedStep(null);
    emit(_viewModel.build());
  }

  void removeStep(Step step) {
    _viewModel.removeStep(step);
    emit(_viewModel.build());
  }

  void setSelectedStep(Step step) {
    _viewModel.setSelectedStep(step);
    emit(_viewModel.build());
  }

  Future<void> deleteRecipe(VoidCallback afterDelete) async {
    _viewModel.deleteRecipe(afterDelete);
  }

  void setRecipeName(String name) {
    _viewModel.setRecipeName(name);
    emit(_viewModel.build());
  }

  void setRecipeDerscription(String description) {
    _viewModel.setRecipeDescription(description);
    emit(_viewModel.build());
  }
}
