class ProfileRequest {
  String userID;
  String nickname;
  String aboutMe;
  String imageUrl;
  String email;
  bool emailConfirmed;

  ProfileRequest({
    required this.userID,
    required this.nickname,
    required this.aboutMe,
    required this.imageUrl,
    required this.email,
    required this.emailConfirmed,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'nickname': nickname,
      'aboutMe': aboutMe,
      'imageUrl': imageUrl,
      'email': email,
      'emailConfirmed': emailConfirmed,
    };
  }
}
