import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/design/buttons/submit_button.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/build_profile.dart';
import 'package:the_ranch_app/screens/edit_profile_screen.dart';
import 'package:the_ranch_app/screens/members_screen.dart';
import 'package:the_ranch_app/screens/memories_screen.dart';
import 'package:the_ranch_app/services/auth.dart';
import 'package:the_ranch_app/services/database.dart';

class ProfileScreen extends StatefulWidget {
  final RanchUser ranchUser;

  const ProfileScreen({Key key, this.ranchUser}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              children: <Widget>[
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
      body: StreamBuilder<RanchUser>(
          stream: database.getUserData(widget.ranchUser.uid),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              RanchUser ranchUser = snapshot.data;
              return Padding(
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: BuildProfile(ranchUser: ranchUser),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Flexible(
                            child: RanchButton(
                              text: 'Members',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MembersScreen(),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: RanchButton(
                              text: 'Edit Info',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                    ranchUser: ranchUser,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: RanchButton(
                              text: 'Memories',
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MemoriesScreen(ranchUser: ranchUser),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
