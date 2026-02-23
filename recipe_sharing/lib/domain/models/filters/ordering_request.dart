import 'recipe_ordering.dart';

class OrderingRequest {
  RecipeOrdering ordering;
  bool ascending;

  OrderingRequest({required this.ordering, required this.ascending});
}
