import 'package:firebase_auth/firebase_auth.dart';


class RanchUser {
  final String uid;
  final String name;
  final String nationality;
  final String aboutMe;
  final String ranchNickname;
  final String wordsForTheRanch;
  final String grade;
  final String profileImage;

  RanchUser(
      {this.uid,
      this.name,
      this.nationality,
      this.aboutMe,
      this.ranchNickname,
      this.wordsForTheRanch,
      this.grade,
      this.profileImage});

  factory RanchUser.getUserFromFirebase(FirebaseUser firebaseUser) {
    return RanchUser(uid: firebaseUser.uid);
  }

  factory RanchUser.getUserProfile(Map<String, dynamic> data, String uid) {
    return RanchUser(
      name: data['name'],
      nationality: data['nationality'],
      aboutMe: data['aboutMe'],
      ranchNickname: data['ranchNickname'],
      wordsForTheRanch: data['wordsForTheRanch'],
      grade: data['grade'],
      profileImage: data['profileImage'],
      uid: uid,
    );
  }

  Map<String, dynamic> ranchUserToJson() {
    return {
      'name': this.name,
      'nationality': this.nationality,
      'aboutMe': this.aboutMe,
      'ranchNickname': this.ranchNickname,
      'wordsForTheRanch': this.wordsForTheRanch,
      'grade' : this.grade,
    };
  }
}
