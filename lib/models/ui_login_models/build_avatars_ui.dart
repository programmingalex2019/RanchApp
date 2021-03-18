import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/ui_login_models/login_avatar_ui.dart';
import 'package:the_ranch_app/providers/select_avatar_manager.dart';

class BuildAvatarsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectEmailManager = Provider.of<SelectAvatarManager>(context);

    return Column(
      children: <Widget>[
        Container(
          height: 250,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 200,
            perspective: 0.005,
            squeeze: 1.0,
            
            physics: FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              selectEmailManager.setCurrentEmail(index);
              selectEmailManager.setCurrentName(index);
              selectEmailManager.setCurrentColor(index);
            },
            childDelegate: ListWheelChildLoopingListDelegate(
              children: LoginAvatarUI.getAvatarUiList(
                  selectEmailManager.getLoginAvatars()),
            ),
          ),
        ),
        SizedBox(height: 80),
        // current selected user name
        Text(
          '${selectEmailManager.currentName}',
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
