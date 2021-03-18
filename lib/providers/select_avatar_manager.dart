import 'package:flutter/cupertino.dart';
import 'package:the_ranch_app/models/ui_login_models/login_avatar.dart';

const List<List<String>> avatarData = [
  [
    'Alex Vanellis',
    'alexvanellis@mail.com',
    'images/alex.jpg',
    'Color(0xff388E3C)'
  ],
  [
    'Andreas Theocharous',
    'andreastheocharous@mail.com',
    'images/andreas.jpg',
    'Color(0xffC6FF00)'
  ],
  ['Alex Costa', 'alexcosta@mail.com', 'images/costa.jpg', 'Color(0xff03A9F4)'],
  [
    'Antonis Antoniou',
    'antonisantoniou@mail.com',
    'images/antonis.jpg',
    'Color(0xff6200EA)'
  ],
  [
    'Petros Kitazos',
    'petroskitazos@mail.com',
    'images/petros.jpg',
    'Color(0xffC2185B)'
  ],
  [
    'Edward Madanat',
    'edwardmadanat@mail.com',
    'images/edward.jpg',
    'Color(0xffFFC107)'
  ],
  [
    'Adam Madanat',
    'adammadanat@mail.com',
    'images/adam.jpg',
    'Color(0xff00BCD4)'
  ],
  [
    'Marios Loizides',
    'mariosloizides@mail.com',
    'images/marios.jpg',
    'Color(0xffd50000)'
  ]
];

class SelectAvatarManager with ChangeNotifier {
  String _currentEmail = avatarData[0][1];
  String _currentName = '';
  Color _currentColor;

  List<LoginAvatar> getLoginAvatars() {
    List<LoginAvatar> avatars = [];

    avatarData.map((value) {
      avatars.add(LoginAvatar(image: value[2]));
    }).toList();

    return avatars;
  }

  String get currentEmail => _currentEmail;
  String get currentName => _currentName;
  Color get currentColor => _currentColor;

  void setCurrentEmail(int index) {
    _currentEmail = avatarData[index][1];
    print(_currentEmail);
    notifyListeners();
  }

  void setCurrentName(int index) {
    _currentName = avatarData[index][0];
    notifyListeners();
  }

  void setCurrentColor(int index) {
    String currentStringColor = avatarData[index][3];
    String valueString = currentStringColor.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    _currentColor = Color(value);
    notifyListeners();
  }
}
