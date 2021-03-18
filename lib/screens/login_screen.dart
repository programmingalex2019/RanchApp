import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/design/buttons/submit_button.dart';
import 'package:the_ranch_app/design/constants.dart';
import 'package:the_ranch_app/models/ui_login_models/build_avatars_ui.dart';
import 'package:the_ranch_app/providers/login_screen_provider.dart';
import 'package:the_ranch_app/providers/select_avatar_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget create(BuildContext context) {
    return Provider<LoginScreenProvider>(
      create: (context) => LoginScreenProvider(),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginManager =
        Provider.of<LoginScreenProvider>(context, listen: false);
    final selectEmailManager = Provider.of<SelectAvatarManager>(context);
    final loadingStateManager = Provider.of<LoadingStateManager>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectEmailManager.currentColor,
        title: Text('LoginScreen'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: loadingStateManager.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // build the listViewWheelScroll of AvatarUI list
                BuildAvatarsUI(),
                SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            child: TextFormField(
                              obscureText: true,
                              autocorrect: false,
                              enableSuggestions: false,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: kTextFieldDesign.copyWith(
                                filled: true,
                                fillColor: selectEmailManager?.currentColor ??
                                    Theme.of(context).accentColor,
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              validator: (value) =>
                                  loginManager.validator(value)
                                      ? null
                                      : 'Can\'t be empty',
                              onSaved: (value) => loginManager.onFormSaved(
                                  selectEmailManager.currentEmail,
                                  value,
                                  context),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      RanchButton(
                          text: 'Let\'s Go',
                          // validates and sign is the user
                          onPressed: () {
                            loginManager.validate(_formKey);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
