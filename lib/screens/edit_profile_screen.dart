import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/design/buttons/submit_button.dart';
import 'package:the_ranch_app/models/property_form_field.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/image_edit/image_capture.dart';
import 'package:the_ranch_app/models/ui_profile_models/image_edit/image_profile_stream_builder.dart';
import 'package:the_ranch_app/providers/edit_profile_manager.dart';

class EditProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RanchUser ranchUser;

  EditProfileScreen({Key key, @required this.ranchUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Profle')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture()));
                  },
                  child: Stack(
                    children: <Widget>[
                      ImageProfileStreamBuilder(ranchUser: ranchUser),
                      Positioned(
                        top: 85.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              width: 120.0,
                              height: 40.0,
                              color: Colors.grey.withOpacity(0.5),
                              child: Icon(Icons.add, color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              // has a non required validator property

                              PropertyFormField(
                                fieldName: 'Your Name',
                                initialValue:
                                    ranchUser.name ?? 'Enter your name',
                                hintText: 'Enter your name',
                                onSaved: (value) => editProfileProvider
                                    .updateName(value.toString()),
                              ),
                              PropertyFormField(
                                fieldName: 'Nationality',
                                initialValue: ranchUser.nationality ??
                                    'Enter your Nationality',
                                hintText: 'Enter your Nationality',
                                onSaved: (value) => editProfileProvider
                                    .updateNationality(value.toString()),
                              ),
                              PropertyFormField(
                                fieldName: 'Ranch Nickname',
                                initialValue: ranchUser.ranchNickname ??
                                    'How the ranch calls you?',
                                hintText: 'How the ranch calls you?',
                                onSaved: (value) => editProfileProvider
                                    .updateRanchNickname(value.toString()),
                              ),
                              PropertyFormFieldGrade(
                                fieldName: 'Grade',
                                initialValue: ranchUser.grade ??
                                    'What was your grade?',
                                hintText: 'What was your grade?',
                                onSaved: (value) => editProfileProvider
                                    .updateHeartSize(value.toString()),
                              ),
                              PropertyFormField(
                                maxLines: 10,
                                fieldName: 'About Me',
                                initialValue: ranchUser.aboutMe ??
                                    'Something about yourself',
                                hintText: 'Something about yourself',
                                onSaved: (value) => editProfileProvider
                                    .updateAboutMe(value.toString()),
                              ),
                              PropertyFormField(
                                maxLines: 10,
                                fieldName: 'Words for the Ranch',
                                initialValue: ranchUser.wordsForTheRanch ??
                                    'Say something to the Ranch',
                                hintText: 'Say something to the Ranch',
                                onSaved: (value) => editProfileProvider
                                    .updateWordsForTheRanch(value.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                RanchButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    await editProfileProvider.updateUser();
                    Navigator.pop(context);
                  },
                  text: 'Save',
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
