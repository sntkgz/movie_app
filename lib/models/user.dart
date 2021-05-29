import 'dart:convert';

class Profile {
  String uid;
  String nickName;
  String email;

  Profile({required this.uid, required this.nickName, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nickName': nickName,
      'email': email,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      uid: map['uid'],
      nickName: map['nickName'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
