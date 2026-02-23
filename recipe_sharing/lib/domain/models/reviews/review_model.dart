class ReviewModel {
  String id;
  String userName;
  String userImageUrl;
  String text;
  int rating;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userImageUrl,
    required this.text,
    required this.rating,
  });
}
