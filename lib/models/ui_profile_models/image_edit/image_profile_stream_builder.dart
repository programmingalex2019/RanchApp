import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/image_edit/record.dart';
import 'package:the_ranch_app/services/database.dart';

class ImageProfileStreamBuilder extends StatelessWidget {
  const ImageProfileStreamBuilder({
    Key key,
    @required this.ranchUser,
  }) : super(key: key);

  final RanchUser ranchUser;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: database.currentUserImage(ranchUser.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();

            Record record = Record(url: snapshot.data.data['profileImage']);

            return CircleAvatar(
              backgroundImage: record.url != ''
                  ? NetworkImage(record.url)
                  : AssetImage('images/cowboy.png'),
              radius: 60.0,
            );
          }),
    );
  }
}
