import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/screens/login_screen.dart';
import 'package:the_ranch_app/screens/profile_screen.dart';
import 'package:the_ranch_app/services/auth.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<RanchUser>(
      stream: auth.userAuthState,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return LoginScreen.create(context);
        } else {
          return ProfileScreen(ranchUser: snapshot.data);
        }
      },
    );
  }
}
