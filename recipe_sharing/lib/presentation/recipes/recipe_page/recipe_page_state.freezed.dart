// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecipePageState {
  String? get selectedRecipeId => throw _privateConstructorUsedError;
  APIResult<Recipe> get recipe => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String get recipeName => throw _privateConstructorUsedError;
  String get recipeDescription => throw _privateConstructorUsedError;
  double get recipeRating => throw _privateConstructorUsedError;
  int get recipeReviewsCount => throw _privateConstructorUsedError;
  bool get own => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  List<Ingredient> get ingredients => throw _privateConstructorUsedError;
  List<Step> get steps => throw _privateConstructorUsedError;
  List<String> get filters => throw _privateConstructorUsedError;
  APIResult<Map<String, List<String>>> get loadedFilters =>
      throw _privateConstructorUsedError;
  APIResult<List<ReviewModel>> get reviews =>
      throw _privateConstructorUsedError;
  bool get isEditingRecord => throw _privateConstructorUsedError;
  bool get openAddIngredientDialog => throw _privateConstructorUsedError;
  bool get openFiltersPage => throw _privateConstructorUsedError;
  bool get openAddStepDialog => throw _privateConstructorUsedError;
  bool get openConfirmDeleteDialog => throw _privateConstructorUsedError;
  Step? get selectedStep => throw _privateConstructorUsedError;
  int get selectedStepIndex => throw _privateConstructorUsedError;
  Ingredient? get selectedIngredient => throw _privateConstructorUsedError;
  int get selectedIngrIndex => throw _privateConstructorUsedError;
  String? get infoMessage => throw _privateConstructorUsedError;
  int get selectedRecipeTabIndex => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;

  /// Create a copy of RecipePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipePageStateCopyWith<RecipePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipePageStateCopyWith<$Res> {
  factory $RecipePageStateCopyWith(
    RecipePageState value,
    $Res Function(RecipePageState) then,
  ) = _$RecipePageStateCopyWithImpl<$Res, RecipePageState>;
  @useResult
  $Res call({
    String? selectedRecipeId,
    APIResult<Recipe> recipe,
    String? imageUrl,
    String recipeName,
    String recipeDescription,
    double recipeRating,
    int recipeReviewsCount,
    bool own,
    bool isFavorite,
    List<Ingredient> ingredients,
    List<Step> steps,
    List<String> filters,
    APIResult<Map<String, List<String>>> loadedFilters,
    APIResult<List<ReviewModel>> reviews,
    bool isEditingRecord,
    bool openAddIngredientDialog,
    bool openFiltersPage,
    bool openAddStepDialog,
    bool openConfirmDeleteDialog,
    Step? selectedStep,
    int selectedStepIndex,
    Ingredient? selectedIngredient,
    int selectedIngrIndex,
    String? infoMessage,
    int selectedRecipeTabIndex,
    bool isError,
  });
}

/// @nodoc
class _$RecipePageStateCopyWithImpl<$Res, $Val extends RecipePageState>
    implements $RecipePageStateCopyWith<$Res> {
  _$RecipePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedRecipeId = freezed,
    Object? recipe = null,
    Object? imageUrl = freezed,
    Object? recipeName = null,
    Object? recipeDescription = null,
    Object? recipeRating = null,
    Object? recipeReviewsCount = null,
    Object? own = null,
    Object? isFavorite = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? filters = null,
    Object? loadedFilters = null,
    Object? reviews = null,
    Object? isEditingRecord = null,
    Object? openAddIngredientDialog = null,
    Object? openFiltersPage = null,
    Object? openAddStepDialog = null,
    Object? openConfirmDeleteDialog = null,
    Object? selectedStep = freezed,
    Object? selectedStepIndex = null,
    Object? selectedIngredient = freezed,
    Object? selectedIngrIndex = null,
    Object? infoMessage = freezed,
    Object? selectedRecipeTabIndex = null,
    Object? isError = null,
  }) {
    return _then(
      _value.copyWith(
            selectedRecipeId: freezed == selectedRecipeId
                ? _value.selectedRecipeId
                : selectedRecipeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipe: null == recipe
                ? _value.recipe
                : recipe // ignore: cast_nullable_to_non_nullable
                      as APIResult<Recipe>,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            recipeName: null == recipeName
                ? _value.recipeName
                : recipeName // ignore: cast_nullable_to_non_nullable
                      as String,
            recipeDescription: null == recipeDescription
                ? _value.recipeDescription
                : recipeDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            recipeRating: null == recipeRating
                ? _value.recipeRating
                : recipeRating // ignore: cast_nullable_to_non_nullable
                      as double,
            recipeReviewsCount: null == recipeReviewsCount
                ? _value.recipeReviewsCount
                : recipeReviewsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            own: null == own
                ? _value.own
                : own // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            ingredients: null == ingredients
                ? _value.ingredients
                : ingredients // ignore: cast_nullable_to_non_nullable
                      as List<Ingredient>,
            steps: null == steps
                ? _value.steps
                : steps // ignore: cast_nullable_to_non_nullable
                      as List<Step>,
            filters: null == filters
                ? _value.filters
                : filters // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            loadedFilters: null == loadedFilters
                ? _value.loadedFilters
                : loadedFilters // ignore: cast_nullable_to_non_nullable
                      as APIResult<Map<String, List<String>>>,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as APIResult<List<ReviewModel>>,
            isEditingRecord: null == isEditingRecord
                ? _value.isEditingRecord
                : isEditingRecord // ignore: cast_nullable_to_non_nullable
                      as bool,
            openAddIngredientDialog: null == openAddIngredientDialog
                ? _value.openAddIngredientDialog
                : openAddIngredientDialog // ignore: cast_nullable_to_non_nullable
                      as bool,
            openFiltersPage: null == openFiltersPage
                ? _value.openFiltersPage
                : openFiltersPage // ignore: cast_nullable_to_non_nullable
                      as bool,
            openAddStepDialog: null == openAddStepDialog
                ? _value.openAddStepDialog
                : openAddStepDialog // ignore: cast_nullable_to_non_nullable
                      as bool,
            openConfirmDeleteDialog: null == openConfirmDeleteDialog
                ? _value.openConfirmDeleteDialog
                : openConfirmDeleteDialog // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedStep: freezed == selectedStep
                ? _value.selectedStep
                : selectedStep // ignore: cast_nullable_to_non_nullable
                      as Step?,
            selectedStepIndex: null == selectedStepIndex
                ? _value.selectedStepIndex
                : selectedStepIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedIngredient: freezed == selectedIngredient
                ? _value.selectedIngredient
                : selectedIngredient // ignore: cast_nullable_to_non_nullable
                      as Ingredient?,
            selectedIngrIndex: null == selectedIngrIndex
                ? _value.selectedIngrIndex
                : selectedIngrIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            infoMessage: freezed == infoMessage
                ? _value.infoMessage
                : infoMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedRecipeTabIndex: null == selectedRecipeTabIndex
                ? _value.selectedRecipeTabIndex
                : selectedRecipeTabIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            isError: null == isError
                ? _value.isError
                : isError // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipePageStateImplCopyWith<$Res>
    implements $RecipePageStateCopyWith<$Res> {
  factory _$$RecipePageStateImplCopyWith(
    _$RecipePageStateImpl value,
    $Res Function(_$RecipePageStateImpl) then,
  ) = __$$RecipePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? selectedRecipeId,
    APIResult<Recipe> recipe,
    String? imageUrl,
    String recipeName,
    String recipeDescription,
    double recipeRating,
    int recipeReviewsCount,
    bool own,
    bool isFavorite,
    List<Ingredient> ingredients,
    List<Step> steps,
    List<String> filters,
    APIResult<Map<String, List<String>>> loadedFilters,
    APIResult<List<ReviewModel>> reviews,
    bool isEditingRecord,
    bool openAddIngredientDialog,
    bool openFiltersPage,
    bool openAddStepDialog,
    bool openConfirmDeleteDialog,
    Step? selectedStep,
    int selectedStepIndex,
    Ingredient? selectedIngredient,
    int selectedIngrIndex,
    String? infoMessage,
    int selectedRecipeTabIndex,
    bool isError,
  });
}

/// @nodoc
class __$$RecipePageStateImplCopyWithImpl<$Res>
    extends _$RecipePageStateCopyWithImpl<$Res, _$RecipePageStateImpl>
    implements _$$RecipePageStateImplCopyWith<$Res> {
  __$$RecipePageStateImplCopyWithImpl(
    _$RecipePageStateImpl _value,
    $Res Function(_$RecipePageStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedRecipeId = freezed,
    Object? recipe = null,
    Object? imageUrl = freezed,
    Object? recipeName = null,
    Object? recipeDescription = null,
    Object? recipeRating = null,
    Object? recipeReviewsCount = null,
    Object? own = null,
    Object? isFavorite = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? filters = null,
    Object? loadedFilters = null,
    Object? reviews = null,
    Object? isEditingRecord = null,
    Object? openAddIngredientDialog = null,
    Object? openFiltersPage = null,
    Object? openAddStepDialog = null,
    Object? openConfirmDeleteDialog = null,
    Object? selectedStep = freezed,
    Object? selectedStepIndex = null,
    Object? selectedIngredient = freezed,
    Object? selectedIngrIndex = null,
    Object? infoMessage = freezed,
    Object? selectedRecipeTabIndex = null,
    Object? isError = null,
  }) {
    return _then(
      _$RecipePageStateImpl(
        selectedRecipeId: freezed == selectedRecipeId
            ? _value.selectedRecipeId
            : selectedRecipeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipe: null == recipe
            ? _value.recipe
            : recipe // ignore: cast_nullable_to_non_nullable
                  as APIResult<Recipe>,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        recipeName: null == recipeName
            ? _value.recipeName
            : recipeName // ignore: cast_nullable_to_non_nullable
                  as String,
        recipeDescription: null == recipeDescription
            ? _value.recipeDescription
            : recipeDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        recipeRating: null == recipeRating
            ? _value.recipeRating
            : recipeRating // ignore: cast_nullable_to_non_nullable
                  as double,
        recipeReviewsCount: null == recipeReviewsCount
            ? _value.recipeReviewsCount
            : recipeReviewsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        own: null == own
            ? _value.own
            : own // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        ingredients: null == ingredients
            ? _value._ingredients
            : ingredients // ignore: cast_nullable_to_non_nullable
                  as List<Ingredient>,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<Step>,
        filters: null == filters
            ? _value._filters
            : filters // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        loadedFilters: null == loadedFilters
            ? _value.loadedFilters
            : loadedFilters // ignore: cast_nullable_to_non_nullable
                  as APIResult<Map<String, List<String>>>,
        reviews: null == reviews
            ? _value.reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as APIResult<List<ReviewModel>>,
        isEditingRecord: null == isEditingRecord
            ? _value.isEditingRecord
            : isEditingRecord // ignore: cast_nullable_to_non_nullable
                  as bool,
        openAddIngredientDialog: null == openAddIngredientDialog
            ? _value.openAddIngredientDialog
            : openAddIngredientDialog // ignore: cast_nullable_to_non_nullable
                  as bool,
        openFiltersPage: null == openFiltersPage
            ? _value.openFiltersPage
            : openFiltersPage // ignore: cast_nullable_to_non_nullable
                  as bool,
        openAddStepDialog: null == openAddStepDialog
            ? _value.openAddStepDialog
            : openAddStepDialog // ignore: cast_nullable_to_non_nullable
                  as bool,
        openConfirmDeleteDialog: null == openConfirmDeleteDialog
            ? _value.openConfirmDeleteDialog
            : openConfirmDeleteDialog // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedStep: freezed == selectedStep
            ? _value.selectedStep
            : selectedStep // ignore: cast_nullable_to_non_nullable
                  as Step?,
        selectedStepIndex: null == selectedStepIndex
            ? _value.selectedStepIndex
            : selectedStepIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedIngredient: freezed == selectedIngredient
            ? _value.selectedIngredient
            : selectedIngredient // ignore: cast_nullable_to_non_nullable
                  as Ingredient?,
        selectedIngrIndex: null == selectedIngrIndex
            ? _value.selectedIngrIndex
            : selectedIngrIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        infoMessage: freezed == infoMessage
            ? _value.infoMessage
            : infoMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedRecipeTabIndex: null == selectedRecipeTabIndex
            ? _value.selectedRecipeTabIndex
            : selectedRecipeTabIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        isError: null == isError
            ? _value.isError
            : isError // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RecipePageStateImpl implements _RecipePageState {
  const _$RecipePageStateImpl({
    this.selectedRecipeId = null,
    this.recipe = const APIResultLoading(),
    this.imageUrl = null,
    this.recipeName = '',
    this.recipeDescription = '',
    this.recipeRating = 0.0,
    this.recipeReviewsCount = 0,
    this.own = false,
    this.isFavorite = false,
    final List<Ingredient> ingredients = const [],
    final List<Step> steps = const [],
    final List<String> filters = const [],
    this.loadedFilters = const APIResultLoading(),
    this.reviews = const APIResultLoading(),
    this.isEditingRecord = false,
    this.openAddIngredientDialog = false,
    this.openFiltersPage = false,
    this.openAddStepDialog = false,
    this.openConfirmDeleteDialog = false,
    this.selectedStep = null,
    this.selectedStepIndex = -1,
    this.selectedIngredient = null,
    this.selectedIngrIndex = -1,
    this.infoMessage = null,
    this.selectedRecipeTabIndex = 0,
    this.isError = false,
  }) : _ingredients = ingredients,
       _steps = steps,
       _filters = filters;

  @override
  @JsonKey()
  final String? selectedRecipeId;
  @override
  @JsonKey()
  final APIResult<Recipe> recipe;
  @override
  @JsonKey()
  final String? imageUrl;
  @override
  @JsonKey()
  final String recipeName;
  @override
  @JsonKey()
  final String recipeDescription;
  @override
  @JsonKey()
  final double recipeRating;
  @override
  @JsonKey()
  final int recipeReviewsCount;
  @override
  @JsonKey()
  final bool own;
  @override
  @JsonKey()
  final bool isFavorite;
  final List<Ingredient> _ingredients;
  @override
  @JsonKey()
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<Step> _steps;
  @override
  @JsonKey()
  List<Step> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  final List<String> _filters;
  @override
  @JsonKey()
  List<String> get filters {
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filters);
  }

  @override
  @JsonKey()
  final APIResult<Map<String, List<String>>> loadedFilters;
  @override
  @JsonKey()
  final APIResult<List<ReviewModel>> reviews;
  @override
  @JsonKey()
  final bool isEditingRecord;
  @override
  @JsonKey()
  final bool openAddIngredientDialog;
  @override
  @JsonKey()
  final bool openFiltersPage;
  @override
  @JsonKey()
  final bool openAddStepDialog;
  @override
  @JsonKey()
  final bool openConfirmDeleteDialog;
  @override
  @JsonKey()
  final Step? selectedStep;
  @override
  @JsonKey()
  final int selectedStepIndex;
  @override
  @JsonKey()
  final Ingredient? selectedIngredient;
  @override
  @JsonKey()
  final int selectedIngrIndex;
  @override
  @JsonKey()
  final String? infoMessage;
  @override
  @JsonKey()
  final int selectedRecipeTabIndex;
  @override
  @JsonKey()
  final bool isError;

  @override
  String toString() {
    return 'RecipePageState(selectedRecipeId: $selectedRecipeId, recipe: $recipe, imageUrl: $imageUrl, recipeName: $recipeName, recipeDescription: $recipeDescription, recipeRating: $recipeRating, recipeReviewsCount: $recipeReviewsCount, own: $own, isFavorite: $isFavorite, ingredients: $ingredients, steps: $steps, filters: $filters, loadedFilters: $loadedFilters, reviews: $reviews, isEditingRecord: $isEditingRecord, openAddIngredientDialog: $openAddIngredientDialog, openFiltersPage: $openFiltersPage, openAddStepDialog: $openAddStepDialog, openConfirmDeleteDialog: $openConfirmDeleteDialog, selectedStep: $selectedStep, selectedStepIndex: $selectedStepIndex, selectedIngredient: $selectedIngredient, selectedIngrIndex: $selectedIngrIndex, infoMessage: $infoMessage, selectedRecipeTabIndex: $selectedRecipeTabIndex, isError: $isError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipePageStateImpl &&
            (identical(other.selectedRecipeId, selectedRecipeId) ||
                other.selectedRecipeId == selectedRecipeId) &&
            (identical(other.recipe, recipe) || other.recipe == recipe) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.recipeName, recipeName) ||
                other.recipeName == recipeName) &&
            (identical(other.recipeDescription, recipeDescription) ||
                other.recipeDescription == recipeDescription) &&
            (identical(other.recipeRating, recipeRating) ||
                other.recipeRating == recipeRating) &&
            (identical(other.recipeReviewsCount, recipeReviewsCount) ||
                other.recipeReviewsCount == recipeReviewsCount) &&
            (identical(other.own, own) || other.own == own) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality().equals(
              other._ingredients,
              _ingredients,
            ) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.loadedFilters, loadedFilters) ||
                other.loadedFilters == loadedFilters) &&
            (identical(other.reviews, reviews) || other.reviews == reviews) &&
            (identical(other.isEditingRecord, isEditingRecord) ||
                other.isEditingRecord == isEditingRecord) &&
            (identical(
                  other.openAddIngredientDialog,
                  openAddIngredientDialog,
                ) ||
                other.openAddIngredientDialog == openAddIngredientDialog) &&
            (identical(other.openFiltersPage, openFiltersPage) ||
                other.openFiltersPage == openFiltersPage) &&
            (identical(other.openAddStepDialog, openAddStepDialog) ||
                other.openAddStepDialog == openAddStepDialog) &&
            (identical(
                  other.openConfirmDeleteDialog,
                  openConfirmDeleteDialog,
                ) ||
                other.openConfirmDeleteDialog == openConfirmDeleteDialog) &&
            (identical(other.selectedStep, selectedStep) ||
                other.selectedStep == selectedStep) &&
            (identical(other.selectedStepIndex, selectedStepIndex) ||
                other.selectedStepIndex == selectedStepIndex) &&
            (identical(other.selectedIngredient, selectedIngredient) ||
                other.selectedIngredient == selectedIngredient) &&
            (identical(other.selectedIngrIndex, selectedIngrIndex) ||
                other.selectedIngrIndex == selectedIngrIndex) &&
            (identical(other.infoMessage, infoMessage) ||
                other.infoMessage == infoMessage) &&
            (identical(other.selectedRecipeTabIndex, selectedRecipeTabIndex) ||
                other.selectedRecipeTabIndex == selectedRecipeTabIndex) &&
            (identical(other.isError, isError) || other.isError == isError));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    selectedRecipeId,
    recipe,
    imageUrl,
    recipeName,
    recipeDescription,
    recipeRating,
    recipeReviewsCount,
    own,
    isFavorite,
    const DeepCollectionEquality().hash(_ingredients),
    const DeepCollectionEquality().hash(_steps),
    const DeepCollectionEquality().hash(_filters),
    loadedFilters,
    reviews,
    isEditingRecord,
    openAddIngredientDialog,
    openFiltersPage,
    openAddStepDialog,
    openConfirmDeleteDialog,
    selectedStep,
    selectedStepIndex,
    selectedIngredient,
    selectedIngrIndex,
    infoMessage,
    selectedRecipeTabIndex,
    isError,
  ]);

  /// Create a copy of RecipePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipePageStateImplCopyWith<_$RecipePageStateImpl> get copyWith =>
      __$$RecipePageStateImplCopyWithImpl<_$RecipePageStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RecipePageState implements RecipePageState {
  const factory _RecipePageState({
    final String? selectedRecipeId,
    final APIResult<Recipe> recipe,
    final String? imageUrl,
    final String recipeName,
    final String recipeDescription,
    final double recipeRating,
    final int recipeReviewsCount,
    final bool own,
    final bool isFavorite,
    final List<Ingredient> ingredients,
    final List<Step> steps,
    final List<String> filters,
    final APIResult<Map<String, List<String>>> loadedFilters,
    final APIResult<List<ReviewModel>> reviews,
    final bool isEditingRecord,
    final bool openAddIngredientDialog,
    final bool openFiltersPage,
    final bool openAddStepDialog,
    final bool openConfirmDeleteDialog,
    final Step? selectedStep,
    final int selectedStepIndex,
    final Ingredient? selectedIngredient,
    final int selectedIngrIndex,
    final String? infoMessage,
    final int selectedRecipeTabIndex,
    final bool isError,
  }) = _$RecipePageStateImpl;

  @override
  String? get selectedRecipeId;
  @override
  APIResult<Recipe> get recipe;
  @override
  String? get imageUrl;
  @override
  String get recipeName;
  @override
  String get recipeDescription;
  @override
  double get recipeRating;
  @override
  int get recipeReviewsCount;
  @override
  bool get own;
  @override
  bool get isFavorite;
  @override
  List<Ingredient> get ingredients;
  @override
  List<Step> get steps;
  @override
  List<String> get filters;
  @override
  APIResult<Map<String, List<String>>> get loadedFilters;
  @override
  APIResult<List<ReviewModel>> get reviews;
  @override
  bool get isEditingRecord;
  @override
  bool get openAddIngredientDialog;
  @override
  bool get openFiltersPage;
  @override
  bool get openAddStepDialog;
  @override
  bool get openConfirmDeleteDialog;
  @override
  Step? get selectedStep;
  @override
  int get selectedStepIndex;
  @override
  Ingredient? get selectedIngredient;
  @override
  int get selectedIngrIndex;
  @override
  String? get infoMessage;
  @override
  int get selectedRecipeTabIndex;
  @override
  bool get isError;

  /// Create a copy of RecipePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipePageStateImplCopyWith<_$RecipePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
