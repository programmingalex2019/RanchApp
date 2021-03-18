import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/design/dark_theme_provider.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/build_profile.dart';
import 'package:the_ranch_app/services/auth.dart';

class MemberProfileScreen extends StatelessWidget {
  final RanchUser ranchUser;

  const MemberProfileScreen({Key key, this.ranchUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Member Profile'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: darkThemeProvider.darkTheme,
                  onChanged: (bool value) {
                    darkThemeProvider.darkTheme = value;
                  },
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () async => await auth.signOut(),
                  child: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Scrollbar(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: BuildProfile(ranchUser: ranchUser),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
