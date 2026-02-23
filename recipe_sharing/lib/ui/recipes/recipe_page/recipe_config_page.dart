import 'package:flutter/material.dart'
    show
        AlertDialog,
        AnimatedContainer,
        AnimatedOpacity,
        AppBar,
        Axis,
        Border,
        BorderRadius,
        BoxDecoration,
        BoxFit,
        BoxShape,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Color,
        Colors,
        Column,
        Container,
        CustomScrollView,
        EdgeInsets,
        ElevatedButton,
        Expanded,
        GestureDetector,
        Icon,
        IconButton,
        Icons,
        Image,
        InputDecoration,
        ListView,
        MainAxisAlignment,
        MainAxisSize,
        Navigator,
        Opacity,
        OutlineInputBorder,
        OutlinedButton,
        Padding,
        Radius,
        RefreshIndicator,
        RoundedRectangleBorder,
        Row,
        Scaffold,
        SingleChildScrollView,
        SingleTickerProviderStateMixin,
        Size,
        SizedBox,
        SliverPadding,
        SliverToBoxAdapter,
        StatefulWidget,
        Tab,
        TabBar,
        TabBarView,
        TabController,
        Text,
        TextAlign,
        TextButton,
        TextField,
        TextOverflow,
        Theme,
        ThemeData,
        VoidCallback,
        Widget,
        kBottomNavigationBarHeight;
import 'package:flutter/widgets.dart' show State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_sharing/data/helpers/count_to_formatted_string.dart';
import 'package:recipe_sharing/ui/recipes/recipe_page/editable_steps_rows.dart';
import 'package:recipe_sharing/ui/recipes/recipe_page/ingredient_cell.dart'
    show IngredientCell;
import 'package:recipe_sharing/ui/recipes/recipe_page/ingredient_configure_dialog.dart';
import 'package:recipe_sharing/ui/recipes/recipe_page/step_configure_dialog.dart';
import '../../../domain/models/api_result.dart';
import '../../../domain/models/recipes/ingredient.dart';
import '../../../domain/models/recipes/measure.dart';
import '../../../domain/models/recipes/recipe_difficulty.dart';
import '../../../presentation/recipes/recipe_page/recipe_page_cubit.dart';
import '../../../presentation/recipes/recipe_page/recipe_page_state.dart';
import '../../../presentation/recipes/recipe_page/recipe_tabs.dart';
import '../../filter/fitlers_page.dart';
import '../../reviews/review_card.dart';
import '../../stadard/error_info_page.dart';
import '../../../domain/models/recipes/step.dart' show Step;
import '../recipes_screen/rating_row.dart';

class RecipeConfigPage extends StatefulWidget {
  final String? recipeId;

  const RecipeConfigPage({super.key, required this.recipeId});

  @override
  State<RecipeConfigPage> createState() => _RecipeConfigPageState();
}

class _RecipeConfigPageState extends State<RecipeConfigPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: RecipeTabs.values.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _getDifficultyTint(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.beginner:
        return const Color(0xFF388E3C);
      case RecipeDifficulty.common:
        return const Color(0xFFCCC916);
      case RecipeDifficulty.adept:
        return const Color(0xFFE3700B);
      case RecipeDifficulty.masterpiece:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => RecipePageCubit()..loadRecipe(widget.recipeId),
      child: BlocBuilder<RecipePageCubit, RecipePageState>(
        builder: (blocContext, state) {
          final fraction = state.isEditingRecord ? 0.4 : 0.8;
          return Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(40, 40),
                ),
              ),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              foregroundColor: theme.colorScheme.onSurfaceVariant,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Recipe',
                  style: theme.textTheme.headlineMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              actions: state.openFiltersPage
                  ? []
                  : state.isEditingRecord && state.own
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: state.recipe.data?.recipeID != null
                            ? () {
                                blocContext
                                    .read<RecipePageCubit>()
                                    .discardChanges();
                              }
                            : null,
                      ),
                    ]
                  : state.own
                  ? [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          blocContext.read<RecipePageCubit>().setEditRecord(
                            true,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: state.recipe.data?.recipeID != null
                            ? () {
                                blocContext
                                    .read<RecipePageCubit>()
                                    .setOpenConfirmDeleteDialog(true);
                              }
                            : null,
                      ),
                    ]
                  : [
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: state.recipe.data?.recipeID != null
                            ? () {
                                // TODO() add posting review page
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          state.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onPressed: () {
                          blocContext
                              .read<RecipePageCubit>()
                              .changeIsFavorite();
                        },
                      ),
                    ],
            ),
            bottomNavigationBar: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height:
                  state.own && state.isEditingRecord && !state.openFiltersPage
                  ? kBottomNavigationBarHeight
                  : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity:
                    state.own && state.isEditingRecord && !state.openFiltersPage
                    ? 1
                    : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: ElevatedButton(
                    onPressed: state.isError
                        ? null
                        : () {
                            blocContext.read<RecipePageCubit>().saveChanges();
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    child: Text('Confirm', style: theme.textTheme.titleMedium),
                  ),
                ),
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 8),
                  sliver: SliverToBoxAdapter(
                    child: RefreshIndicator(
                      child: _buildBody(
                        theme,
                        fraction,
                        state,
                        () {
                          blocContext.read<RecipePageCubit>().loadRecipe(
                            state.selectedRecipeId,
                          );
                        },
                        () {
                          blocContext.read<RecipePageCubit>().loadFilters();
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().setFilters(value);
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().removeFilter(
                            value,
                          );
                        },
                        (value) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setOpenFiltersPage(value);
                        },
                        (value) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setOpenStepConfigureDialog(value);
                        },
                        (index, value) {
                          blocContext.read<RecipePageCubit>().updateStep(
                            index,
                            value,
                          );
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().addStep(value);
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().setSelectedStep(
                            value,
                          );
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().removeStep(value);
                        },
                        (value) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setOpenIngredientConfigureDialog(value);
                        },
                        (index, value) {
                          blocContext.read<RecipePageCubit>().updateIngredient(
                            index,
                            value,
                          );
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().addIngredient(
                            value,
                          );
                        },
                        (value) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setSelectedIngredient(value);
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().removeIngredient(
                            value,
                          );
                        },
                        () async {
                          blocContext.read<RecipePageCubit>().deleteRecipe(() {
                            Navigator.pop(context);
                          });
                        },
                        (open) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setOpenConfirmDeleteDialog(open);
                        },
                        (value) {
                          blocContext.read<RecipePageCubit>().setRecipeName(
                            value,
                          );
                        },
                        (value) {
                          blocContext
                              .read<RecipePageCubit>()
                              .setRecipeDerscription(value);
                        },
                      ),
                      onRefresh: () async {
                        blocContext.read<RecipePageCubit>().loadRecipe(
                          state.selectedRecipeId,
                        );
                      },
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

  Widget _buildBody(
    ThemeData theme,
    double fraction,
    RecipePageState state,
    VoidCallback onReloadData,
    VoidCallback onLoadFilters,
    Function(List<String>) onSetFilters,
    Function(String) onRemoveFilter,
    Function(bool) onSetOpenFiltersPage,
    Function(bool) onSetOpenStepConfigureDialog,
    Function(int, Step) onUpdateStep,
    Function(Step) onAddStep,
    Function(Step) onSetSelectedStep,
    Function(Step) onRemoveStep,
    Function(bool) onSetOpenIngredientConfigureDialog,
    Function(int, Ingredient) onUpdateIngredient,
    Function(Ingredient) onAddIngredient,
    Function(Ingredient) onSetSelectedIngredient,
    Function(Ingredient) onRemoveIngredient,
    VoidCallback onDeleteRecipe,
    Function(bool) onSetOpenConfirmDeleteDialog,
    Function(String) onSetRecipeName,
    Function(String) onSetRecipeDescription,
  ) {
    if (state.openFiltersPage) {
      if (state.loadedFilters is APIResultLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.loadedFilters is APIResultError) {
        return ErrorInfoPage(
          errorInfo: state.loadedFilters.info ?? 'Unknown error',
          onReloadPage: onLoadFilters,
        );
      } else if (state.loadedFilters is APIResultSucceed) {
        if (state.loadedFilters.data != null) {
          return FiltersPage(
            categorizedItems: state.loadedFilters.data!,
            onFiltersConfirmed: (filters) {
              onSetFilters(filters);
              onSetOpenFiltersPage(false);
            },
            onCancelChanges: () {
              onSetOpenFiltersPage(false);
            },
          );
        } else {
          return Center(
            child: Text(
              'No saved filters',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        }
      }
    }

    final recipe = state.recipe;

    if (recipe is APIResultLoading) {
      return CircularProgressIndicator();
    } else if (recipe is APIResultError) {
      return ErrorInfoPage(
        errorInfo: recipe.info ?? 'Unknown error',
        onReloadPage: () {
          onReloadData();
        },
      );
    } else if (recipe is APIResultSucceed) {
      if (recipe.data == null) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          if (state.openAddIngredientDialog)
            IngredientConfigureDialog(
              ingredient:
                  state.selectedIngredient ??
                  Ingredient(name: '', amount: 0, measureType: Measure.gram),
              onDismissRequest: () {
                onSetOpenIngredientConfigureDialog(false);
              },
              onSaveChanges: (ingredient) {
                if (state.selectedIngrIndex >= 0) {
                  onUpdateIngredient(state.selectedIngrIndex, ingredient);
                } else {
                  onAddIngredient(ingredient);
                }
                onSetOpenStepConfigureDialog(false);
              },
            ),
          if (state.openAddStepDialog)
            StepConfigureDialog(
              step:
                  state.selectedStep ??
                  Step(description: '', durationMinutes: 0),
              onDismissRequest: () {
                onSetOpenStepConfigureDialog(false);
              },
              onSaveChanges: (step) {
                if (state.selectedStepIndex >= 0) {
                  onUpdateStep(state.selectedStepIndex, step);
                } else {
                  onAddStep(step);
                }
                onSetOpenStepConfigureDialog(false);
              },
            ),

          if (state.openConfirmDeleteDialog)
            AlertDialog(
              icon: const Icon(Icons.warning, color: Colors.red),
              title: Text('Confirm Delete'),
              content: Text(
                'Are you sure you want to delete "${state.recipeName}"?',
                textAlign: TextAlign.justify,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    onDeleteRecipe();
                  },
                  child: Text('Confirm', style: theme.textTheme.titleLarge),
                ),
                TextButton(
                  onPressed: () {
                    onSetOpenConfirmDeleteDialog(false);
                  },
                  child: Text(
                    'Cancel',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          GestureDetector(
            onTap: () {
              // TODO() add pick image
            },
            child: Container(
              width: double.infinity,
              height: 300 * fraction,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: Image.asset('assets/no_image.png', fit: BoxFit.cover),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: RecipeTabs.values.map((tab) {
              return Tab(text: tab.name);
            }).toList(),
          ),
          SizedBox(
            height: 800,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(
                  theme,
                  state,
                  onRemoveFilter,
                  onSetRecipeName,
                  onSetRecipeDescription,
                  onSetOpenFiltersPage,
                ),
                _buildIngredientsTab(
                  theme,
                  state,
                  onSetSelectedIngredient,
                  onRemoveIngredient,
                  onSetOpenIngredientConfigureDialog,
                ),
                _buildInstructionsTab(
                  theme,
                  state,
                  onSetSelectedStep,
                  onRemoveStep,
                  onSetOpenStepConfigureDialog,
                  onAddStep,
                  onUpdateStep,
                ),
                _buildReviewsTab(theme, state),
              ],
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildInfoTab(
    ThemeData theme,
    RecipePageState state,
    Function(String) onRemoveFilter,
    Function(String) onSetRecipeName,
    Function(String) onSetRecipeDescription,
    Function(bool) onSetOpenFiltersPage,
  ) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.filters.map((filter) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(filter),
                          if (state.isEditingRecord)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 16),
                              onPressed: () {
                                onRemoveFilter(filter);
                              },
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (state.isEditingRecord)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, size: 32),
                  onPressed: () {
                    onSetOpenFiltersPage(true);
                  },
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        if (state.isEditingRecord)
          TextField(
            decoration: InputDecoration(
              labelText: 'Recipe name',
              errorText: state.recipeName.isEmpty
                  ? 'Field cannot be empty'
                  : null,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              onSetRecipeName(value);
            },
          )
        else
          Row(
            children: [
              Expanded(
                child: Text(
                  state.recipeName,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.kitchen,
                    color: _getDifficultyTint(
                      state.recipe.data?.difficulty ??
                          RecipeDifficulty.beginner,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (state.recipe.data?.difficulty ?? RecipeDifficulty.beginner)
                        .name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: _getDifficultyTint(
                        state.recipe.data?.difficulty ??
                            RecipeDifficulty.beginner,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        const SizedBox(height: 12),

        if (!state.isEditingRecord)
          Row(
            children: [
              RatingRow(currentRating: state.recipeRating),
              const SizedBox(width: 4),
              Text(
                '(${state.recipeReviewsCount.toAmountStringFormatted()})',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        const SizedBox(height: 12),

        if (state.isEditingRecord)
          TextField(
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) {
              onSetRecipeDescription(value);
            },
          )
        else
          Text(
            state.recipeDescription,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
      ],
    );
  }

  Widget _buildIngredientsTab(
    ThemeData theme,
    RecipePageState state,
    Function(Ingredient) onSetSelectedIngredient,
    Function(Ingredient) onRemoveIngredient,
    Function(bool) onSetOpenIngredientConfigureDialog,
  ) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        if (state.ingredients.isEmpty)
          Center(
            child: Text(
              'No ingredients',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        if (state.isEditingRecord)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: OutlinedButton.icon(
              onPressed: () {
                onSetSelectedIngredient(
                  Ingredient(name: '', amount: 0, measureType: Measure.gram),
                );
                onSetOpenIngredientConfigureDialog(true);
              },
              icon: const Icon(Icons.add),
              label: Text('Add Ingredient'),
            ),
          ),
        ...state.ingredients.map((ingredient) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(child: IngredientCell(ingredient: ingredient)),
                if (state.isEditingRecord)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: () {
                          onSetSelectedIngredient(ingredient);
                          onSetOpenIngredientConfigureDialog(true);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: () {
                          onRemoveIngredient(ingredient);
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildInstructionsTab(
    ThemeData theme,
    RecipePageState state,
    Function(Step) onSetSelectedStep,
    Function(Step) onRemoveStep,
    Function(bool) onSetOpenStepConfigure,
    Function(Step) onAddStep,
    Function(int, Step) onUpdateStep,
  ) {
    return EditableStepsRows(
      steps: state.steps,
      canEdit: state.own && state.isEditingRecord,
      onAddClick: () {
        onSetSelectedStep(Step(description: '', durationMinutes: 0.0));
        onSetOpenStepConfigure(true);
      },
      onEditClick: (step) {
        onSetSelectedStep(step);
        onSetOpenStepConfigure(true);
      },
      onDeleteClick: (step) {
        onRemoveStep(step);
      },
    );
  }

  Widget _buildReviewsTab(ThemeData theme, RecipePageState state) {
    if (state.reviews is APIResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.reviews is APIResultError) {
      return Center(
        child: Opacity(
          opacity: 0.5,
          child: Text(
            'Failed to load reviews',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      );
    } else if (state.reviews is APIResultSucceed) {
      if (state.reviews.data == null || state.reviews.data!.isEmpty) {
        return Center(
          child: Opacity(
            opacity: 0.5,
            child: Text(
              'No reviews yet',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        );
      }

      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO add reviews page navigator
                  },
                  child: Text(
                    'View all reviews',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                if (!state.own)
                  IconButton(
                    icon: const Icon(Icons.add_comment),
                    onPressed: () {
                      // TODO add navigation to reviews page
                    },
                  ),
              ],
            ),
          ),
          ...state.reviews.data!.map((review) {
            return Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ReviewCard(review: review),
            );
          }),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
