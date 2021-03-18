import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/member_ranch_card.dart';
import 'package:the_ranch_app/services/database.dart';

class MembersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Database database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Members Screen')),
      body: FutureBuilder(
        // data will be updated only when MembersScreen rebuilt ,
        // so take that in notice for decentant widgets
        future: database.getRanchMembers(),
        builder: (context, snapshot) {
          if (snapshot == null) {
            return Center(child: CircularProgressIndicator());
          }
          List<RanchUser> ranchMembers = snapshot.data;
          return ListView.builder(
            itemCount: ranchMembers?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: MemberRanchCard(ranchUser: ranchMembers[index]),
              );
            },
          );
        },
      ),
    );
  }
}
