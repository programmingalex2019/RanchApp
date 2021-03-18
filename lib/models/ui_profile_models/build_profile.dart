import 'package:flutter/material.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/profile_property_card.dart';
import 'package:the_ranch_app/screens/heart_pie_char_screen.dart';

class BuildProfile extends StatelessWidget {
  final RanchUser ranchUser;

  const BuildProfile({Key key, @required this.ranchUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: ranchUser.profileImage != ''
                ? NetworkImage(ranchUser.profileImage)
                : AssetImage('images/cowboy.png'),
            radius: 60.0,
          ),
          SizedBox(height: 20.0),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  ranchUser.name ?? 'Ranch Member',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 35.0),
                ),
              ),
              ProperyCard(
                  propertyName: 'Nationality',
                  propertyValue: ranchUser.nationality ?? ''),
              ProperyCard(
                  propertyName: 'Ranch Nickname',
                  propertyValue: ranchUser.ranchNickname ?? ''),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeartPieChartScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.5),
                      borderRadius: BorderRadius.circular(36.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 260.0,
                          child: Text('Click Here',
                              style: TextStyle(
                                  color: Theme.of(context).hoverColor)),
                        ),
                        ProperyCard(
                            propertyName: 'Grade',
                            propertyValue: ranchUser.grade ?? ''),
                      ],
                    ),
                  ),
                ),
              ),
              ProperyCard(
                  propertyName: 'Words for the Ranch',
                  propertyValue: ranchUser.wordsForTheRanch ?? ''),
              Container(
                child: ProperyCard(
                    propertyName: 'About Me',
                    propertyValue: ranchUser.aboutMe ?? ''),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
