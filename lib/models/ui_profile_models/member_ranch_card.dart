import 'package:flutter/material.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/screens/member_profile_screen.dart';

class MemberRanchCard extends StatelessWidget {
  final RanchUser ranchUser;

  const MemberRanchCard({Key key, @required this.ranchUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MemberProfileScreen(ranchUser: ranchUser),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            border: Border.all(
              color: Color(0xff000000),
              width: 4,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: (ranchUser.profileImage != null &&
                            ranchUser.profileImage != '')
                        ? NetworkImage(ranchUser.profileImage)
                        : AssetImage('images/cowboy.png'),
                  ),
                ),
                Expanded(
                  child: Text(
                    ranchUser.name ?? 'RanchMember',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 14.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    (ranchUser.ranchNickname != null &&
                            ranchUser.ranchNickname != '')
                        ? ranchUser.ranchNickname
                        : 'RanchNickname',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 14.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
