import 'package:bloc/bloc.dart';
import 'package:recipe_sharing/data/repositories/firebase_filters_repository.dart';
import 'package:recipe_sharing/data/repositories/firebase_recipe_repository.dart';
import 'package:recipe_sharing/domain/models/filters/recipe_ordering.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_screen_state.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_viewModel.dart';

class RecipesCubit extends Cubit<RecipesScreenState> {
  final RecipesViewModel _viewModel = RecipesViewModel(
    recipes: FirebaseRecipesRepository(),
    filters: FirebaseFiltersRepository(),
  );
  RecipesCubit() : super(RecipesScreenState());

  Future<void> setLoadDataType(RecipesLoadedDataType loadedDataType) async {
    _viewModel.selectLoadedType(loadedDataType);
    _viewModel.startLoading();
    emit(_viewModel.build());
    await _viewModel.loadRecipes(page: 1);
    emit(_viewModel.build());
  }

  void setSearchName(String searchName) {
    _viewModel.setSearchName(searchName);
    emit(_viewModel.build());
  }

  void setOpenSearchString(bool open) {
    _viewModel.setOpenSearchString(open);
    emit(_viewModel.build());
  }

  Future<void> loadData({required int page, int perPage = 10}) async {
    _viewModel.startLoading();
    emit(_viewModel.build());
    await _viewModel.loadRecipes(page: page, perPage: perPage);
    emit(_viewModel.build());
  }

  void clearFilters() {
    _viewModel.clearSearchedFilters();
    _viewModel.clearSearchedIngredient();
    emit(_viewModel.build());
  }

  Future<void> loadFilters() async {
    _viewModel.startLoading();
    emit(_viewModel.build());
    await _viewModel.loadAvailableFilters();
    emit(_viewModel.build());
  }

  Future<void> setFilters(List<String> fitlers) async {
    _viewModel.setSearchedFilters(fitlers);
    emit(_viewModel.build());
  }

  Future<void> addFilter(String fitler) async {
    _viewModel.addSearchedFilter(fitler);
    emit(_viewModel.build());
  }

  Future<void> removeFilter(String fitler) async {
    _viewModel.removeSearchedFilter(fitler);
    emit(_viewModel.build());
  }

  Future<void> addIngredient(String ingredient) async {
    _viewModel.addSearchedIngredient(ingredient);
    emit(_viewModel.build());
  }

  Future<void> removeIngredient(String ingredient) async {
    _viewModel.removeSearchedIngredient(ingredient);
    emit(_viewModel.build());
  }

  void setOpenFiltersPage(bool open) {
    _viewModel.setOpenFiltersPage(open);
    emit(_viewModel.build());
  }

  void setOpenFiltersTab(bool open) {
    _viewModel.setOpenFiltersTab(open);
    emit(_viewModel.build());
  }

  void setOpenOrderingMenu(bool open) {
    _viewModel.setOpenOrderingMenu(open);
    emit(_viewModel.build());
  }

  void setRecipeOrdering(RecipeOrdering ordering) {
    _viewModel.setOrdering(ordering);
    emit(_viewModel.build());
  }

  void setTimeFrom(int timeFrom) {
    _viewModel.setTimeFrom(timeFrom);
    emit(_viewModel.build());
  }

  void setTimeTo(int timeTo) {
    _viewModel.setTimeTo(timeTo);
    emit(_viewModel.build());
  }
}
