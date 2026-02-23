class RecipeReview {
  String id;
  String recipeID;
  String userID;
  String text;
  int rating;

  RecipeReview({
    required this.id,
    required this.recipeID,
    required this.userID,
    required this.text,
    required this.rating,
  });
}
