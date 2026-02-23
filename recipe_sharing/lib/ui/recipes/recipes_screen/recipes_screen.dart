import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/domain/models/api_result.dart';
import 'package:recipe_sharing/presentation/creators/creators_load_data_type.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_cubit.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_loaded_data_type.dart';
import 'package:recipe_sharing/presentation/recipes/recipes_screen/recipes_screen_state.dart';
import 'package:recipe_sharing/ui/creators/creators_screen.dart';
import 'package:recipe_sharing/ui/filter/fitlers_page.dart';
import 'package:recipe_sharing/ui/recipes/recipe_page/recipe_config_page.dart';
import 'package:recipe_sharing/ui/recipes/recipes_screen/recipe_card.dart';
import 'package:recipe_sharing/ui/recipes/recipes_screen/recipe_ordering_drop_down_menu.dart';
import 'package:recipe_sharing/ui/stadard/error_info_page.dart';
import 'package:recipe_sharing/ui/stadard/page__selection_row.dart';

import '../../filter/filters_tab.dart';
// Import your own packages

class RecipesScreen extends StatefulWidget {
  final RecipesLoadedDataType loadedDataType;

  const RecipesScreen({super.key, required this.loadedDataType});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen>
    with TickerProviderStateMixin {
  late AnimationController _expandFiltersAnimation;
  late Animation<double> _expandRotationAnimation;

  @override
  void initState() {
    super.initState();
    _expandFiltersAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandRotationAnimation = Tween<double>(begin: 0, end: 180).animate(
      CurvedAnimation(parent: _expandFiltersAnimation, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _expandFiltersAnimation.dispose();
    super.dispose();
  }

  String _getPageTitle() {
    switch (widget.loadedDataType) {
      case RecipesLoadedDataTypeFavorites():
        return 'Favorites';
      case RecipesLoadedDataTypeOwn():
        return 'My Recipes';
      default:
        return 'Recipes';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => RecipesCubit()
        ..setLoadDataType(widget.loadedDataType)
        ..loadFilters(),
      child: BlocBuilder<RecipesCubit, RecipesScreenState>(
        builder: (blocContext, state) {
          if (state.expandFiltersTab) {
            _expandFiltersAnimation.forward();
          }
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/no_image.png',
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.currentUserName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          state.currentUserEmail,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Recipes'),
                        selected:
                            state.recipesLoadedDataType
                                is RecipesLoadedDataTypeAll,
                        onTap: () {
                          try {
                            blocContext.read<RecipesCubit>().setLoadDataType(
                              RecipesLoadedDataTypeAll(),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No such route")),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.shopping_basket_outlined),
                        title: Text('Own Recipes'),
                        selected:
                            state.recipesLoadedDataType
                                is RecipesLoadedDataTypeOwn,
                        onTap: () {
                          try {
                            blocContext.read<RecipesCubit>().setLoadDataType(
                              RecipesLoadedDataTypeOwn(),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No such route")),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.shopping_basket_outlined),
                        title: Text('Favorite Recipes'),
                        selected:
                            state.recipesLoadedDataType
                                is RecipesLoadedDataTypeFavorites,
                        onTap: () {
                          try {
                            blocContext.read<RecipesCubit>().setLoadDataType(
                              RecipesLoadedDataTypeFavorites(),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No such route")),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Creators'),
                        selected: false,
                        onTap: () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CreatorsScreen(
                                    dataType: CreatorsLoadDataType.all,
                                  );
                                },
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No such route")),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text('Follows'),
                        selected: false,
                        onTap: () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CreatorsScreen(
                                    dataType: CreatorsLoadDataType.follows,
                                  );
                                },
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("No such route")),
                            );
                          }
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  blocContext,
                  MaterialPageRoute(
                    builder: (context) => RecipeConfigPage(recipeId: null),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                          final offsetAnimation =
                              Tween<Offset>(
                                begin: state.openSearch
                                    ? const Offset(0, 1)
                                    : const Offset(0, -1),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              );

                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            ),
                          );
                        },
                    child: state.openSearch
                        ? Padding(
                            key: const ValueKey('search'),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Recipe name',
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              onChanged: (value) => (blocContext
                                  .read<RecipesCubit>()
                                  .setSearchName(value)),
                            ),
                          )
                        : Padding(
                            key: const ValueKey('title'),
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _getPageTitle(),
                              style: theme.textTheme.headlineMedium,
                            ),
                          ),
                  ),
                  actions: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: state.openSearch
                          ? IconButton(
                              key: const ValueKey('clear'),
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                blocContext.read<RecipesCubit>().setSearchName(
                                  '',
                                );
                                blocContext
                                    .read<RecipesCubit>()
                                    .setOpenSearchString(false);
                              },
                            )
                          : IconButton(
                              key: const ValueKey('search'),
                              icon: const Icon(Icons.search),
                              onPressed: () => {
                                blocContext
                                    .read<RecipesCubit>()
                                    .setOpenSearchString(true),
                              },
                            ),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 8),
                  sliver: SliverToBoxAdapter(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        blocContext.read<RecipesCubit>().loadData(
                          page: state.currentPage,
                        );
                      },
                      child: state.openFiltersPage
                          ? state.loadedFilters is APIResultLoading
                                ? CircularProgressIndicator(strokeWidth: 8)
                                : state.loadedFilters is APIResultError ||
                                      state.loadedFilters.data == null
                                ? ErrorInfoPage(
                                    errorInfo:
                                        state.loadedFilters.info ??
                                        "Error while obtaining filters.",
                                    onReloadPage: () {
                                      blocContext
                                          .read<RecipesCubit>()
                                          .loadFilters();
                                    },
                                  )
                                : SizedBox(
                                    height: 500,
                                    child: FiltersPage(
                                      categorizedItems:
                                          state.loadedFilters.data!,
                                      onFiltersConfirmed: (filters) {
                                        blocContext
                                            .read<RecipesCubit>()
                                            .setFilters(filters);
                                        blocContext
                                            .read<RecipesCubit>()
                                            .setOpenFiltersPage(false);
                                      },
                                      onCancelChanges: () {
                                        blocContext
                                            .read<RecipesCubit>()
                                            .setOpenFiltersPage(false);
                                      },
                                    ),
                                  )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: GestureDetector(
                                          onTap: () {
                                            blocContext
                                                .read<RecipesCubit>()
                                                .setOpenFiltersTab(
                                                  !state.expandFiltersTab,
                                                );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              children: [
                                                RotationTransition(
                                                  turns:
                                                      _expandRotationAnimation,
                                                  child: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text('Filters'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.filter_list,
                                          size: 32,
                                        ),
                                        onPressed: () {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .setOpenFiltersPage(
                                                !state.openFiltersPage,
                                              );
                                        },
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: RecipeOrderingDropDownMenu(
                                          onDismissRequest: () {
                                            blocContext
                                                .read<RecipesCubit>()
                                                .setOpenOrderingMenu(
                                                  !state.openSelectOrderingMenu,
                                                );
                                          },
                                          onSelectOrdering: (ordering) {
                                            blocContext
                                                .read<RecipesCubit>()
                                                .setRecipeOrdering(ordering);
                                          },
                                          selectedOrder: state.recipeOrdering,
                                          isAscending: state.ascending,
                                          expanded:
                                              state.openSelectOrderingMenu,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                state.expandFiltersTab
                                    ? FiltersTab(
                                        filters: state.searchedFilters ?? [],
                                        ingredients:
                                            state.searchedIngredients ?? [],
                                        onRemoveFilter: (filter) {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .removeFilter(filter);
                                        },
                                        onAddIngredient: (ingredient) {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .addIngredient(ingredient);
                                        },
                                        onRemoveIngredient: (ingredient) {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .removeIngredient(ingredient);
                                        },
                                        timeFrom: state.timeFrom,
                                        timeTo: state.timeTo,
                                        onConfirmFilters: () {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .loadData(page: 1);
                                        },
                                        onClearFilters: () {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .clearFilters();
                                        },
                                        onTimeFromChanged: (value) {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .setTimeFrom(value);
                                        },
                                        onTimeToChanged: (value) {
                                          blocContext
                                              .read<RecipesCubit>()
                                              .setTimeTo(value);
                                        },
                                      )
                                    : const SizedBox.shrink(),
                                if (state.recipes is APIResultLoading)
                                  CircularProgressIndicator()
                                else if (state.recipes is APIResultError)
                                  ErrorInfoPage(
                                    errorInfo:
                                        state.recipes.info ?? 'Unknown error',
                                    onReloadPage: () {
                                      blocContext.read<RecipesCubit>().loadData(
                                        page: state.currentPage,
                                      );
                                    },
                                  )
                                else if (state.recipes is APIResultSucceed)
                                  if (state.recipes.data == null ||
                                      state.recipes.data!.result.isEmpty)
                                    Center(
                                      child: Opacity(
                                        opacity: 0.2,
                                        child: Text('No recipes'),
                                      ),
                                    )
                                  else
                                    Column(
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 0.7,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 24,
                                              ),
                                          itemCount:
                                              state.recipes.data!.result.length,
                                          itemBuilder: (context, index) {
                                            final recipe = state
                                                .recipes
                                                .data!
                                                .result[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 4,
                                                    horizontal: 8,
                                                  ),
                                              child: GestureDetector(
                                                key: ValueKey(recipe.recipeID),
                                                onTap: () {
                                                  Navigator.push(
                                                    blocContext,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RecipeConfigPage(
                                                            recipeId:
                                                                recipe.recipeID,
                                                          ),
                                                    ),
                                                  );
                                                },
                                                child: RecipeCard(
                                                  recipe: recipe,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        PageSelectionRow(
                                          totalPages:
                                              state.recipes.data!.totalPages,
                                          currentPage:
                                              state.recipes.data!.currentPage,
                                          onPageClick: (page) {
                                            blocContext
                                                .read<RecipesCubit>()
                                                .loadData(page: page);
                                          },
                                        ),
                                      ],
                                    ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
