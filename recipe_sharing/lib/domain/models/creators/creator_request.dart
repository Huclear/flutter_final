class CreatorRequest {
  String userID;
  String nickname;
  String email;
  String? aboutMe;
  String? imageUrl;
  int recipesCount;
  int followersCount;

  CreatorRequest({
    required this.userID,
    required this.nickname,
    required this.email,
    this.aboutMe,
    this.imageUrl,
    this.recipesCount = 0,
    this.followersCount = 0,
  });
}