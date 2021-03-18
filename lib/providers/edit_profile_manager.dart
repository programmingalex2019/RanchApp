import 'package:flutter/widgets.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/services/database.dart';

class EditProfileProvider with ChangeNotifier {
  Database database = Database();

  String name = '';
  String nationality = '';
  String aboutMe = '';
  String ranchNickname = '';
  String wordsForTheRanch = '';
  String grade = '';

  // updateName
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateNationality(String value) {
    nationality = value;
    notifyListeners();
  }

  void updateAboutMe(String value) {
    aboutMe = value;
    notifyListeners();
  }

  void updateRanchNickname(String value) {
    ranchNickname = value;
    notifyListeners();
  }

  void updateWordsForTheRanch(String value) {
    wordsForTheRanch = value;
    notifyListeners();
  }

  void updateHeartSize(String value) {
    grade = value;
    notifyListeners();
  }

  Future<void> updateUser() async {
    RanchUser ranchUser = RanchUser(
        name: name,
        nationality: nationality,
        aboutMe: aboutMe,
        ranchNickname: ranchNickname,
        wordsForTheRanch: wordsForTheRanch,
        grade: grade);
    await database.updateUserData(data: ranchUser.ranchUserToJson());
  }
}
