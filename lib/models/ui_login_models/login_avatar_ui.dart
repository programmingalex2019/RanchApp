import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ui_login_models/login_avatar.dart';
import 'package:the_ranch_app/providers/select_avatar_manager.dart';

class LoginAvatarUI extends StatelessWidget {
  final String image;

  const LoginAvatarUI({Key key, this.image}) : super(key: key);

  // method on the class to return a list of AvatarUI

  static List<LoginAvatarUI> getAvatarUiList(List<LoginAvatar> avatars) {
    return avatars.map((avatar) => LoginAvatarUI(image: avatar.image)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectEmailManager = Provider.of<SelectAvatarManager>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 5.0,
                  color: selectEmailManager?.currentColor ??
                      Theme.of(context).accentColor),
              borderRadius: BorderRadius.all(
                Radius.circular(100.0),
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
