// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipes_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecipesScreenState {
  String get currentUserName => throw _privateConstructorUsedError;
  String get currentUserEmail => throw _privateConstructorUsedError;
  APIResult<PagedResult<Recipe>> get recipes =>
      throw _privateConstructorUsedError;
  APIResult<Map<String, List<String>>> get loadedFilters =>
      throw _privateConstructorUsedError;
  List<String>? get searchedFilters => throw _privateConstructorUsedError;
  List<String>? get searchedIngredients => throw _privateConstructorUsedError;
  int get timeFrom => throw _privateConstructorUsedError;
  int get timeTo => throw _privateConstructorUsedError;
  RecipeOrdering? get recipeOrdering => throw _privateConstructorUsedError;
  bool get ascending => throw _privateConstructorUsedError;
  String get searchString => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get maxPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  RecipesLoadedDataType get recipesLoadedDataType =>
      throw _privateConstructorUsedError;
  bool get openSearch => throw _privateConstructorUsedError;
  bool get openSelectOrderingMenu => throw _privateConstructorUsedError;
  bool get expandFiltersTab => throw _privateConstructorUsedError;
  bool get openFiltersPage => throw _privateConstructorUsedError;

  /// Create a copy of RecipesScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipesScreenStateCopyWith<RecipesScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipesScreenStateCopyWith<$Res> {
  factory $RecipesScreenStateCopyWith(
    RecipesScreenState value,
    $Res Function(RecipesScreenState) then,
  ) = _$RecipesScreenStateCopyWithImpl<$Res, RecipesScreenState>;
  @useResult
  $Res call({
    String currentUserName,
    String currentUserEmail,
    APIResult<PagedResult<Recipe>> recipes,
    APIResult<Map<String, List<String>>> loadedFilters,
    List<String>? searchedFilters,
    List<String>? searchedIngredients,
    int timeFrom,
    int timeTo,
    RecipeOrdering? recipeOrdering,
    bool ascending,
    String searchString,
    int currentPage,
    int maxPages,
    int pageSize,
    RecipesLoadedDataType recipesLoadedDataType,
    bool openSearch,
    bool openSelectOrderingMenu,
    bool expandFiltersTab,
    bool openFiltersPage,
  });
}

/// @nodoc
class _$RecipesScreenStateCopyWithImpl<$Res, $Val extends RecipesScreenState>
    implements $RecipesScreenStateCopyWith<$Res> {
  _$RecipesScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipesScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserName = null,
    Object? currentUserEmail = null,
    Object? recipes = null,
    Object? loadedFilters = null,
    Object? searchedFilters = freezed,
    Object? searchedIngredients = freezed,
    Object? timeFrom = null,
    Object? timeTo = null,
    Object? recipeOrdering = freezed,
    Object? ascending = null,
    Object? searchString = null,
    Object? currentPage = null,
    Object? maxPages = null,
    Object? pageSize = null,
    Object? recipesLoadedDataType = null,
    Object? openSearch = null,
    Object? openSelectOrderingMenu = null,
    Object? expandFiltersTab = null,
    Object? openFiltersPage = null,
  }) {
    return _then(
      _value.copyWith(
            currentUserName: null == currentUserName
                ? _value.currentUserName
                : currentUserName // ignore: cast_nullable_to_non_nullable
                      as String,
            currentUserEmail: null == currentUserEmail
                ? _value.currentUserEmail
                : currentUserEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            recipes: null == recipes
                ? _value.recipes
                : recipes // ignore: cast_nullable_to_non_nullable
                      as APIResult<PagedResult<Recipe>>,
            loadedFilters: null == loadedFilters
                ? _value.loadedFilters
                : loadedFilters // ignore: cast_nullable_to_non_nullable
                      as APIResult<Map<String, List<String>>>,
            searchedFilters: freezed == searchedFilters
                ? _value.searchedFilters
                : searchedFilters // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            searchedIngredients: freezed == searchedIngredients
                ? _value.searchedIngredients
                : searchedIngredients // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            timeFrom: null == timeFrom
                ? _value.timeFrom
                : timeFrom // ignore: cast_nullable_to_non_nullable
                      as int,
            timeTo: null == timeTo
                ? _value.timeTo
                : timeTo // ignore: cast_nullable_to_non_nullable
                      as int,
            recipeOrdering: freezed == recipeOrdering
                ? _value.recipeOrdering
                : recipeOrdering // ignore: cast_nullable_to_non_nullable
                      as RecipeOrdering?,
            ascending: null == ascending
                ? _value.ascending
                : ascending // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchString: null == searchString
                ? _value.searchString
                : searchString // ignore: cast_nullable_to_non_nullable
                      as String,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            maxPages: null == maxPages
                ? _value.maxPages
                : maxPages // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            recipesLoadedDataType: null == recipesLoadedDataType
                ? _value.recipesLoadedDataType
                : recipesLoadedDataType // ignore: cast_nullable_to_non_nullable
                      as RecipesLoadedDataType,
            openSearch: null == openSearch
                ? _value.openSearch
                : openSearch // ignore: cast_nullable_to_non_nullable
                      as bool,
            openSelectOrderingMenu: null == openSelectOrderingMenu
                ? _value.openSelectOrderingMenu
                : openSelectOrderingMenu // ignore: cast_nullable_to_non_nullable
                      as bool,
            expandFiltersTab: null == expandFiltersTab
                ? _value.expandFiltersTab
                : expandFiltersTab // ignore: cast_nullable_to_non_nullable
                      as bool,
            openFiltersPage: null == openFiltersPage
                ? _value.openFiltersPage
                : openFiltersPage // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecipesScreenStateImplCopyWith<$Res>
    implements $RecipesScreenStateCopyWith<$Res> {
  factory _$$RecipesScreenStateImplCopyWith(
    _$RecipesScreenStateImpl value,
    $Res Function(_$RecipesScreenStateImpl) then,
  ) = __$$RecipesScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String currentUserName,
    String currentUserEmail,
    APIResult<PagedResult<Recipe>> recipes,
    APIResult<Map<String, List<String>>> loadedFilters,
    List<String>? searchedFilters,
    List<String>? searchedIngredients,
    int timeFrom,
    int timeTo,
    RecipeOrdering? recipeOrdering,
    bool ascending,
    String searchString,
    int currentPage,
    int maxPages,
    int pageSize,
    RecipesLoadedDataType recipesLoadedDataType,
    bool openSearch,
    bool openSelectOrderingMenu,
    bool expandFiltersTab,
    bool openFiltersPage,
  });
}

/// @nodoc
class __$$RecipesScreenStateImplCopyWithImpl<$Res>
    extends _$RecipesScreenStateCopyWithImpl<$Res, _$RecipesScreenStateImpl>
    implements _$$RecipesScreenStateImplCopyWith<$Res> {
  __$$RecipesScreenStateImplCopyWithImpl(
    _$RecipesScreenStateImpl _value,
    $Res Function(_$RecipesScreenStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecipesScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUserName = null,
    Object? currentUserEmail = null,
    Object? recipes = null,
    Object? loadedFilters = null,
    Object? searchedFilters = freezed,
    Object? searchedIngredients = freezed,
    Object? timeFrom = null,
    Object? timeTo = null,
    Object? recipeOrdering = freezed,
    Object? ascending = null,
    Object? searchString = null,
    Object? currentPage = null,
    Object? maxPages = null,
    Object? pageSize = null,
    Object? recipesLoadedDataType = null,
    Object? openSearch = null,
    Object? openSelectOrderingMenu = null,
    Object? expandFiltersTab = null,
    Object? openFiltersPage = null,
  }) {
    return _then(
      _$RecipesScreenStateImpl(
        currentUserName: null == currentUserName
            ? _value.currentUserName
            : currentUserName // ignore: cast_nullable_to_non_nullable
                  as String,
        currentUserEmail: null == currentUserEmail
            ? _value.currentUserEmail
            : currentUserEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        recipes: null == recipes
            ? _value.recipes
            : recipes // ignore: cast_nullable_to_non_nullable
                  as APIResult<PagedResult<Recipe>>,
        loadedFilters: null == loadedFilters
            ? _value.loadedFilters
            : loadedFilters // ignore: cast_nullable_to_non_nullable
                  as APIResult<Map<String, List<String>>>,
        searchedFilters: freezed == searchedFilters
            ? _value._searchedFilters
            : searchedFilters // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        searchedIngredients: freezed == searchedIngredients
            ? _value._searchedIngredients
            : searchedIngredients // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        timeFrom: null == timeFrom
            ? _value.timeFrom
            : timeFrom // ignore: cast_nullable_to_non_nullable
                  as int,
        timeTo: null == timeTo
            ? _value.timeTo
            : timeTo // ignore: cast_nullable_to_non_nullable
                  as int,
        recipeOrdering: freezed == recipeOrdering
            ? _value.recipeOrdering
            : recipeOrdering // ignore: cast_nullable_to_non_nullable
                  as RecipeOrdering?,
        ascending: null == ascending
            ? _value.ascending
            : ascending // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchString: null == searchString
            ? _value.searchString
            : searchString // ignore: cast_nullable_to_non_nullable
                  as String,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        maxPages: null == maxPages
            ? _value.maxPages
            : maxPages // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        recipesLoadedDataType: null == recipesLoadedDataType
            ? _value.recipesLoadedDataType
            : recipesLoadedDataType // ignore: cast_nullable_to_non_nullable
                  as RecipesLoadedDataType,
        openSearch: null == openSearch
            ? _value.openSearch
            : openSearch // ignore: cast_nullable_to_non_nullable
                  as bool,
        openSelectOrderingMenu: null == openSelectOrderingMenu
            ? _value.openSelectOrderingMenu
            : openSelectOrderingMenu // ignore: cast_nullable_to_non_nullable
                  as bool,
        expandFiltersTab: null == expandFiltersTab
            ? _value.expandFiltersTab
            : expandFiltersTab // ignore: cast_nullable_to_non_nullable
                  as bool,
        openFiltersPage: null == openFiltersPage
            ? _value.openFiltersPage
            : openFiltersPage // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RecipesScreenStateImpl implements _RecipesScreenState {
  const _$RecipesScreenStateImpl({
    this.currentUserName = '',
    this.currentUserEmail = '',
    this.recipes = const APIResultLoading(),
    this.loadedFilters = const APIResultLoading(),
    final List<String>? searchedFilters = null,
    final List<String>? searchedIngredients = null,
    this.timeFrom = 0,
    this.timeTo = 99999,
    this.recipeOrdering = null,
    this.ascending = true,
    this.searchString = '',
    this.currentPage = 1,
    this.maxPages = 1,
    this.pageSize = 10,
    this.recipesLoadedDataType = const RecipesLoadedDataTypeAll(),
    this.openSearch = false,
    this.openSelectOrderingMenu = false,
    this.expandFiltersTab = false,
    this.openFiltersPage = false,
  }) : _searchedFilters = searchedFilters,
       _searchedIngredients = searchedIngredients;

  @override
  @JsonKey()
  final String currentUserName;
  @override
  @JsonKey()
  final String currentUserEmail;
  @override
  @JsonKey()
  final APIResult<PagedResult<Recipe>> recipes;
  @override
  @JsonKey()
  final APIResult<Map<String, List<String>>> loadedFilters;
  final List<String>? _searchedFilters;
  @override
  @JsonKey()
  List<String>? get searchedFilters {
    final value = _searchedFilters;
    if (value == null) return null;
    if (_searchedFilters is EqualUnmodifiableListView) return _searchedFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _searchedIngredients;
  @override
  @JsonKey()
  List<String>? get searchedIngredients {
    final value = _searchedIngredients;
    if (value == null) return null;
    if (_searchedIngredients is EqualUnmodifiableListView)
      return _searchedIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int timeFrom;
  @override
  @JsonKey()
  final int timeTo;
  @override
  @JsonKey()
  final RecipeOrdering? recipeOrdering;
  @override
  @JsonKey()
  final bool ascending;
  @override
  @JsonKey()
  final String searchString;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int maxPages;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final RecipesLoadedDataType recipesLoadedDataType;
  @override
  @JsonKey()
  final bool openSearch;
  @override
  @JsonKey()
  final bool openSelectOrderingMenu;
  @override
  @JsonKey()
  final bool expandFiltersTab;
  @override
  @JsonKey()
  final bool openFiltersPage;

  @override
  String toString() {
    return 'RecipesScreenState(currentUserName: $currentUserName, currentUserEmail: $currentUserEmail, recipes: $recipes, loadedFilters: $loadedFilters, searchedFilters: $searchedFilters, searchedIngredients: $searchedIngredients, timeFrom: $timeFrom, timeTo: $timeTo, recipeOrdering: $recipeOrdering, ascending: $ascending, searchString: $searchString, currentPage: $currentPage, maxPages: $maxPages, pageSize: $pageSize, recipesLoadedDataType: $recipesLoadedDataType, openSearch: $openSearch, openSelectOrderingMenu: $openSelectOrderingMenu, expandFiltersTab: $expandFiltersTab, openFiltersPage: $openFiltersPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipesScreenStateImpl &&
            (identical(other.currentUserName, currentUserName) ||
                other.currentUserName == currentUserName) &&
            (identical(other.currentUserEmail, currentUserEmail) ||
                other.currentUserEmail == currentUserEmail) &&
            (identical(other.recipes, recipes) || other.recipes == recipes) &&
            (identical(other.loadedFilters, loadedFilters) ||
                other.loadedFilters == loadedFilters) &&
            const DeepCollectionEquality().equals(
              other._searchedFilters,
              _searchedFilters,
            ) &&
            const DeepCollectionEquality().equals(
              other._searchedIngredients,
              _searchedIngredients,
            ) &&
            (identical(other.timeFrom, timeFrom) ||
                other.timeFrom == timeFrom) &&
            (identical(other.timeTo, timeTo) || other.timeTo == timeTo) &&
            (identical(other.recipeOrdering, recipeOrdering) ||
                other.recipeOrdering == recipeOrdering) &&
            (identical(other.ascending, ascending) ||
                other.ascending == ascending) &&
            (identical(other.searchString, searchString) ||
                other.searchString == searchString) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.maxPages, maxPages) ||
                other.maxPages == maxPages) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.recipesLoadedDataType, recipesLoadedDataType) ||
                other.recipesLoadedDataType == recipesLoadedDataType) &&
            (identical(other.openSearch, openSearch) ||
                other.openSearch == openSearch) &&
            (identical(other.openSelectOrderingMenu, openSelectOrderingMenu) ||
                other.openSelectOrderingMenu == openSelectOrderingMenu) &&
            (identical(other.expandFiltersTab, expandFiltersTab) ||
                other.expandFiltersTab == expandFiltersTab) &&
            (identical(other.openFiltersPage, openFiltersPage) ||
                other.openFiltersPage == openFiltersPage));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    currentUserName,
    currentUserEmail,
    recipes,
    loadedFilters,
    const DeepCollectionEquality().hash(_searchedFilters),
    const DeepCollectionEquality().hash(_searchedIngredients),
    timeFrom,
    timeTo,
    recipeOrdering,
    ascending,
    searchString,
    currentPage,
    maxPages,
    pageSize,
    recipesLoadedDataType,
    openSearch,
    openSelectOrderingMenu,
    expandFiltersTab,
    openFiltersPage,
  ]);

  /// Create a copy of RecipesScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipesScreenStateImplCopyWith<_$RecipesScreenStateImpl> get copyWith =>
      __$$RecipesScreenStateImplCopyWithImpl<_$RecipesScreenStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RecipesScreenState implements RecipesScreenState {
  const factory _RecipesScreenState({
    final String currentUserName,
    final String currentUserEmail,
    final APIResult<PagedResult<Recipe>> recipes,
    final APIResult<Map<String, List<String>>> loadedFilters,
    final List<String>? searchedFilters,
    final List<String>? searchedIngredients,
    final int timeFrom,
    final int timeTo,
    final RecipeOrdering? recipeOrdering,
    final bool ascending,
    final String searchString,
    final int currentPage,
    final int maxPages,
    final int pageSize,
    final RecipesLoadedDataType recipesLoadedDataType,
    final bool openSearch,
    final bool openSelectOrderingMenu,
    final bool expandFiltersTab,
    final bool openFiltersPage,
  }) = _$RecipesScreenStateImpl;

  @override
  String get currentUserName;
  @override
  String get currentUserEmail;
  @override
  APIResult<PagedResult<Recipe>> get recipes;
  @override
  APIResult<Map<String, List<String>>> get loadedFilters;
  @override
  List<String>? get searchedFilters;
  @override
  List<String>? get searchedIngredients;
  @override
  int get timeFrom;
  @override
  int get timeTo;
  @override
  RecipeOrdering? get recipeOrdering;
  @override
  bool get ascending;
  @override
  String get searchString;
  @override
  int get currentPage;
  @override
  int get maxPages;
  @override
  int get pageSize;
  @override
  RecipesLoadedDataType get recipesLoadedDataType;
  @override
  bool get openSearch;
  @override
  bool get openSelectOrderingMenu;
  @override
  bool get expandFiltersTab;
  @override
  bool get openFiltersPage;

  /// Create a copy of RecipesScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipesScreenStateImplCopyWith<_$RecipesScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
